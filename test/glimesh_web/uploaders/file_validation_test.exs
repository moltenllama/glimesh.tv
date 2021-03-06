defmodule Glimesh.FileValidationTest do
  use Glimesh.DataCase

  @png_file "test/support/fixtures/files/200x200.png"
  @jpg_file "test/support/fixtures/files/200x200.jpg"

  describe "file validation" do
    test "validate/2 matches file types" do
      waffle_mock = %Waffle.File{
        path: @png_file
      }

      assert Glimesh.FileValidation.validate(waffle_mock, [:png])
      refute Glimesh.FileValidation.validate(waffle_mock, [:jpg])
    end

    test "get_file_type/1 returns expected output" do
      assert {:ok, :png} ==
               Glimesh.FileValidation.get_file_type(@png_file)

      assert {:ok, :jpg} ==
               Glimesh.FileValidation.get_file_type(@jpg_file)

      assert {:ok, :unknown} ==
               Glimesh.FileValidation.get_file_type("test/test_helper.exs")

      assert {:error, "no such file or directory"} ==
               Glimesh.FileValidation.get_file_type("non-existant-file")
    end
  end
end
