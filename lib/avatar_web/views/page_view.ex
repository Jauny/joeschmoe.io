defmodule AvatarWeb.PageView do
  use AvatarWeb, :view

  def random_avatar do
    Svg.build(hair: "3",
      eyes: "2",
      nose: "2",
      sweater: "1",
      mouth: "1",
      collar: "2")
  end

end
