defmodule ElixirBetWeb.AssignRoleLive do
  use ElixirBetWeb, :live_view

  require Logger

  alias ElixirBet.Repo
  alias ElixirBet.Accounts.User
  alias ElixirBet.Roles.Role

  def mount(_params, _session, socket) do
    users = Repo.all(User)
    roles = Repo.all(Role)

    {:ok, assign(socket, changeset: %{}, users: users, roles: roles)}
  end



  def render(assigns) do
    ~L"""
    <div class="flex h-screen bg-gray-200">
  <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">
    <nav class="text-white text-base font-semibold pt-3">
      <button onclick="location.href='/dashboard'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tachometer-alt mr-3"></i>
        Dashboard
      </button>
      <button onclick="location.href='/users'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-sticky-note mr-3"></i>
        Users
      </button>
      <button onclick="location.href='/roles'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-sticky-note mr-3"></i>
        Roles
      </button>
      <button onclick="location.href='/permissions'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-table mr-3"></i>
        Permissions
      </button>
      <button onclick="location.href='/teams'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-table mr-3"></i>
        Teams
      </button>
      <button onclick="location.href='/leagues'" class="flex items-center active-nav-link text-white py-4 pl-6 nav-item">
        <i class="fas fa-align-left mr-3"></i>
        Leagues
      </button>
      <button onclick="location.href='/matches'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Matches
      </button>
      <button onclick="location.href='/wallets'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Wallet
      </button>
      <button onclick="location.href='/bets'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Bets
      </button>
      <button onclick="location.href='/history'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Bet History
      </button>
    </nav>
  </aside>

  <main class="w-full flex-grow p-6">
    <h1 class="text-3xl text-black pb-6">Assign Roles</h1>
          <div class="leading-loose">
      <form phx-submit="assign_role_to_user" class="p-10 bg-gray-900 rounded shadow-xl">
        <div>
          <label class="block text-sm text-gray-600" for="role">Role Name</label>
          <select id="role" name="role" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
            <option selected disabled>Select Role</option>
            <%= for role <- @roles do %>
              <option value="<%= role.id %>"><%= role.name %></option>
            <% end %>
          </select>
        </div>

        <div class="mt-2">
          <label class="block text-sm text-gray-600" for="user">User</label>
          <select id="user" name="user" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
            <option selected disabled>Select User</option>
            <%= for user <- @users do %>
              <option value="<%= user.id %>"><%= "#{user.first_name} #{user.last_name}" %></option>
            <% end %>
          </select>
        </div>

        <div class="mt-6">
          <button class="px-4 py-1 text-white font-light tracking-wider bg-orange-700 rounded" type="submit">Submit</button>
        </div>
      </form>
    </div>
  </main>
</div>
    """
  end

  def handle_event("assign_role_to_user", %{"role" => role_id, "user" => user_id}, socket) do
    case Repo.get(Role, role_id) do
      nil ->
        {:noreply, put_flash(socket, :error, "Role not found.")}

      role ->
        case Repo.get(User, user_id) do
          nil ->
            {:noreply, put_flash(socket, :error, "User not found.")}

          user ->
            changeset = User.role_changeset(user, %{role_id: role.id})

            case Repo.update(changeset) do
              {:ok, _user} ->
                {:noreply, put_flash(socket, :success, "Role assigned successfully.")}

              {:error, changeset} ->
                Logger.error("Failed to assign role: #{inspect(changeset.errors)}")
                {:noreply, put_flash(socket, :error, "Failed to assign role. #{inspect(changeset.errors)}")}
            end
        end
    end
  end

  def handle_event("assign_role_to_user", _params, socket) do
    {:noreply, assign(socket, error: "Invalid parameters.")}
  end
end
