defmodule AvatarWeb.PageView do
  use AvatarWeb, :view

  def all_originals do
    Svg.originals_path
    |> Enum.map(fn path ->
      String.split(path, "static") |> Enum.at(1) 
    end)
  end

  def random_original do
    Svg.random_original
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
