defmodule AvatarWeb.TestLive do
  use Phoenix.LiveView
  alias AvatarWeb.PageView

  def render(assigns), do: AvatarWeb.PageView.render("index_live.html", assigns)

  def mount(_session, socket) do
    {:ok, assign(socket, val: "random")}
  end

  def handle_event("update-avatar", %{"q" => name}, socket) do
    case name do
      "" -> {:noreply, assign(socket, :val, "random")}
      _  -> {:noreply, assign(socket, :val, name)}
    end
  end
end
