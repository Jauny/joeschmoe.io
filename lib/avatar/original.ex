defmodule Avatar.Original do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
    |> validate_inclusion(
      :gender, ["female", "male"],
      message: "should be either male or female")
  end

  def get_by_name(name) do
    Avatar.Original |> Avatar.Repo.get_by(name: name)
  end

  def get_from_string(string) do
    originals = Avatar.Original |> Avatar.Repo.all
    Enum.at(originals, string
                       |> to_charlist
                       |> Enum.reduce(fn el, acc -> el + acc end)
                       |> rem(length(originals)))
  end

  def get_from_string_and_gender(string, gender) do
    originals = Avatar.Original |> where(gender: ^gender) |> Avatar.Repo.all
    case Enum.find(originals, fn o -> o.name == string end) do
      res -> res
      nil -> Enum.at(originals, string
                                |> to_charlist
                                |> Enum.reduce(fn el, acc -> el + acc end)
                                |> rem(length(originals)))
    end
  end

  @doc """
  Creates an original.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Original{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Avatar.Original{}
    |> Avatar.Original.changeset(attrs)
    |> Avatar.Repo.insert()
  end
end
