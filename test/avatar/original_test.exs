defmodule Avatar.OriginalTest do
  use Avatar.DataCase

  describe "Original" do
    alias Avatar.Original

    @valid_attrs %{gender: "female", name: "Jess", svg: "<xml></xml>"}

    test "gender must be either female or male" do
      attrs = %{@valid_attrs | gender: "dog"}
      changeset = Original.changeset(%Original{}, attrs)
      assert %{gender: ["should be either male or female"]} = errors_on(changeset)
    end
  end
end
