defmodule AvatarWeb.TestLive do
  use Phoenix.LiveView
  alias AvatarWeb.PageView

  def render(assigns) do
    #PageView.render("index.html", assigns)
    ~L"""
    <div class="two-cols">
      <div class="two-cols__col">
        <form phx-change="update-avatar">
          <div class="input-wrapper">
            <label for="sandbox__input">identifier</label>
            <div class="input">
              <span class="input__before">https://joeschmoe.io/api/v1/</span>
              <div class="input-cursor">
                <input name="q" autocomplete="off" id="sandbox__input" type="text" placeholder="<seed>" />
                <i class="cursor"></i>
              </div>
              <input id="sandbox__hidden" class="hidden" value="https://joeschmoe.io/api/v1/<%= @val %>" />
            </div>
          </div>
          <a class="btn btn--pulse" id="sandbox__copy-btn" onClick="copyInputValue('#sandbox')">Copy</a>
        </form>
      </div>

      <div class="two-cols__col sandbox__img">
        <img class="schmoe" id="sandbox__img" src="/api/local/<%= @val %>" />
      </div>
    </div>
    """
  end

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
