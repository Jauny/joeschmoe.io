defmodule Avatar.Original do
  use Ecto.Schema
  import Ecto.Changeset

  schema "originals" do
    field :gender, :string
    field :name, :string
    field :svg, :string

    timestamps()
  end

  @doc false
  def changeset(original, attrs) do
    original
    |> cast(attrs, [:name, :gender, :svg])
    |> validate_required([:name, :gender, :svg])
  end

  def get_by_name(name) do
    Avatar.Original |> Avatar.Repo.get_by(name: name)
  end

  def get_from_string(string) do
    originals = Avatar.Original |> Avatar.Repo.all
    index = string
            |> to_charlist
            |> Enum.reduce(fn el, acc -> el + acc end)
            |> rem(length(originals))
    Enum.at(originals, index)
  end
end
