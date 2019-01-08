defmodule Svg do
  @moduledoc """
  Svg manipulates SVG files.

  It is used to merge multiple SVG parts and colorize them
  to create our avatars.
  """
  require Exoml

  @doc """
  Generates a random avatar.

  ## Examples

      iex> Svg.random
      "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 125 125\">"...

  """
  def random do
    head    = get_random_head()    |> fill()       |> add_attr("stroke", "black")
    eyes    = get_random_eyes()    |> fill("none") |> add_attr("stroke", "black")
    hair    = get_random_hair()    |> fill()       |> add_attr("stroke", "black")
    mouth   = get_random_mouth()   |> fill()       |> add_attr("stroke", "black")
    nose    = get_random_nose()    |> fill("none") |> add_attr("stroke", "black")
    collar  = get_random_collar()  |> fill()       |> add_attr("stroke", "black")
    sweater = get_random_sweater() |> fill()       |> add_attr("stroke", "black")

    avatar = "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 125 125\">"
    avatar = avatar <>
             stringify(head) <>
             stringify(hair) <>
             stringify(eyes) <>
             stringify(mouth) <>
             stringify(nose) <>
             stringify(collar) <>
             stringify(sweater) <>
             "</svg>"
    #File.write(Path.expand("./svgs/elixir.svg"), avatar)
    #avatar
  end

  def get_element(el_type, id) do
    el_path = Enum.random(Path.wildcard(svg_path() <> "/males/1/" <> el_type <> "/*svg"))
    {:ok, svg} = File.read(Path.expand(el_path))
    Exoml.decode(svg)
  end

  def get_random_element(el_type) do
    el_path = Enum.random(Path.wildcard(svg_path() <> "/males/1/" <> el_type <> "/*svg"))
    {:ok, svg} = File.read(Path.expand(el_path))
    Exoml.decode(svg)
  end

  def get_random_head do
    get_content(get_random_element("heads"))
  end

  def get_random_eyes do
    get_content(get_random_element("eyes"))
  end

  def get_random_hair do
    get_content(get_random_element("hairs"))
  end

  def get_random_mouth do
    get_content(get_random_element("mouths"))
  end

  def get_random_nose do
    get_content(get_random_element("noses"))
  end

  def get_random_collar do
    get_content(get_random_element("collars"))
  end

  def get_random_sweater do
    get_content(get_random_element("sweaters"))
  end

  @doc """
  Get content selects and returns only the <g> element from the svg file.
  Useful when adding an svg file into another.
  """
  def get_content(svg) do
    svg |> elem(2) |> hd |> elem(2) |> Enum.at(1)
  end

  @doc """
  Adds a fill attribute with a random color to the element.
  """
  def fill(el) do
    color = Enum.random(["beige", "red", "blue", "green", "orange"])
    fill(el, color)
  end

  @doc """
  Adds a fill attribute with a value of color to the element.
  """
  def fill(el, color) do
    add_attr(el, "fill", color)
  end

  @doc """
  Adds `attr=value` attribute to the element.
  """
  def add_attr(el, key, value) do
    new_paths = elem(el, 2) |> Enum.map(fn({id, paths, last}) ->
      {id, Enum.map(paths, fn(attr) ->
        case attr do
          {^key, _} -> {key, value}
          _ -> attr
        end
      end), last}
    end)
    put_elem(el, 2, new_paths)
  end

  @doc """
  Returns the raw SVG value as a string.
  """
  def stringify(el) do
    Exoml.encode({:root, [], [el]})
  end

  defp svg_path do
    Path.expand(File.cwd! <> "/assets/static/images/avatars")
  end
end

