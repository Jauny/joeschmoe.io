defmodule AvatarWeb.PageView do
  use AvatarWeb, :view

  alias Avatar.{Repo, Original}

  def all_originals do
    Repo.all(Original)
  end

  def random_original do
    Original |> Repo.all |> Enum.random
  end

  def random_avatar do
    Svg.build(hair: "3",
      eyes: "2",
      nose: "2",
      sweater: "1",
      mouth: "1",
      collar: "2")
  end

end
