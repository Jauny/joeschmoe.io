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
end
