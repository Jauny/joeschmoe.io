defmodule Svg do
  @moduledoc """
  Svg manipulates SVG files.

  It is used to merge multiple SVG parts and colorize them
  to create our avatars.
  """
  require Exoml

  @doc """
  Generates a random avatar.
  """
  def random do
    head    = get_random_head()    |> fill()       |> add_attr("stroke", "black")
    eyes    = get_random_eyes()    |> fill("none") |> add_attr("stroke", "black")
    hair    = get_random_hair()    |> fill()       |> add_attr("stroke", "black")
    mouth   = get_random_mouth()   |> fill()       |> add_attr("stroke", "black")
    nose    = get_random_nose()    |> fill("none") |> add_attr("stroke", "black")
    collar  = get_random_collar()  |> fill()       |> add_attr("stroke", "black")
    sweater = get_random_sweater() |> fill()       |> add_attr("stroke", "black")

    "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 125 125\">" <>
      stringify(head) <>
      stringify(hair) <>
      stringify(eyes) <>
      stringify(mouth) <>
      stringify(nose) <>
      stringify(collar) <>
      stringify(sweater) <>
    "</svg>"
  end

  @doc """
  Builds an avatar from the opts passed in.
  """
  def build(opts \\ []) do
    defaults = [
      gender: "males",
      base: "1",
      head: "1",
      eyes: "1",
      hair: "1",
      mouth: "1",
      nose: "1",
      collar: "1",
      sweater: "1"
    ]
    opts = Keyword.merge(defaults, opts)

    head = get_element(opts[:gender], opts[:base], "heads", opts[:head])
    eyes = get_element(opts[:gender], opts[:base], "eyes", opts[:eyes])
    hair = get_element(opts[:gender], opts[:base], "hairs", opts[:hair])
    mouth = get_element(opts[:gender], opts[:base], "mouths", opts[:mouth])
    nose = get_element(opts[:gender], opts[:base], "noses", opts[:nose])
    collar = get_element(opts[:gender], opts[:base], "collars", opts[:collar])
    sweater = get_element(opts[:gender], opts[:base], "sweaters", opts[:sweater])

    ["<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 125 125\">"] ++
    Enum.map([head, eyes, hair, mouth, nose, collar, sweater], fn el ->
      stringify(el)
    end) ++ ["</svg>"]
    |> Enum.join("")
  end

  def get_element(gender, base, type, index) do
    path = Path.join([svg_path(), gender, base, type, index]) <> ".svg"
    {:ok, svg} = File.read(Path.expand(path))
    get_content(Exoml.decode(svg))
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
  Adds attribute attr=key to either the element if it's a leaf element,
  or all its children recursively, if it's a parent.
  """
  def add_attr(el, key, value) do
    case el do
      {"g", _, _} -> add_attr_to_g(el, key, value)
      _           -> add_attr_to_el(el, key, value)
    end
  end

  @doc """
  Adds an attribute of key=value to the element.
  The element can be a "path", "rect", or other SVG leaf.
  """
  def add_attr_to_el(el, key, value) do
    {name, attrs, last} = el
    attrs = Enum.filter(attrs, fn({name, _}) -> name != key end) ++ [{key, value}]
    {name, attrs, last}
  end

  @doc """
  Adds an attribute of key=value to all children of a group "g".
  """
  def add_attr_to_g(g, key, value) when is_bitstring(value) do
    {name, attrs, children} = g

    children = Enum.map(children, fn(child) ->
      case child do
        {"g", _, _} -> add_attr_to_g(child, key, value)
        _           -> add_attr_to_el(child, key, value)
      end
    end)

    {name, attrs, children} 
  end

  def add_attr_to_g(g, key, values) when is_list(values) do
    {name, attrs, children} = g

    children = children
    |> Enum.with_index
    |> Enum.map(fn({child, index}) ->
      case child do
        {"g", _, _} -> add_attr_to_g(child, key, values)
        _           -> add_attr_to_el(child, key, Enum.at(values, index))
      end
    end)

    {name, attrs, children} 
  end

  @doc """
  Returns the raw SVG value as a string.
  """
  def stringify(el) do
    Exoml.encode({:root, [], [el]})
  end

  def svg_path do
    Path.expand(File.cwd! <> "/assets/static/images/avatars")
  end
end

