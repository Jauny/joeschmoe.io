defmodule AvatarWeb.PageView do
  use AvatarWeb, :view

  def random_avatar do
    Svg.build(hair: "2",
      eyes: "2",
      nose: "2",
      sweater: "3",
      collar: "2")
  end

end
