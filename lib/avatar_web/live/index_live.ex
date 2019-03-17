defmodule AvatarWeb.IndexLive do
  use Phoenix.LiveView

  def render(assigns), do: AvatarWeb.PageView.render("index.html", assigns)

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
