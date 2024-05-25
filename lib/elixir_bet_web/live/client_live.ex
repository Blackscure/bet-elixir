defmodule ElixirBetWeb.ClientLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Accounts
  alias ElixirBet.Repo
  alias ElixirBet.Roles.Role

def mount(_params, _session, socket) do
  current_user = socket.assigns.current_user
  current_user_role_id = current_user.role_id

  users =
    if current_user_role_id == 1 || current_user_role_id == 2 do
      Accounts.list_users()
    else
      [%{
        id: current_user.id,
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        msidn: current_user.msidn,
        email: current_user.email,
        role_id: current_user.role_id,
        inserted_at: current_user.inserted_at,
        updated_at: current_user.updated_at
      }]
    end

  users = case users do
    {:ok, users_list} -> users_list
    _ -> users
  end

  {:ok, users} = {:ok, users}
  IO.inspect(users, label: "Users")
  {:ok, assign(socket, users: users)}
end


  def get_role_name(nil), do: "Unknown role"
  def get_role_name(role_id) do
    case Repo.get(Role, role_id) do
      nil -> "Unknown role"
      role -> role.name
    end
  end


  def handle_event(_, _, socket), do: {:noreply, socket}



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
    <h1 class="text-3xl text-black pb-6">Users</h1>
        <div class="relative overflow-x-auto shadow-md pt-4">

    <div class="w-full">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        First Name
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Last Name
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Mobile Number
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Email
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Role
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Created At
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Action
                    </th>
                </tr>
            </thead>
            <tbody>
                <%= for user <- @users do %>
                <tr class="odd:bg-white odd:dark:bg-gray-900 even:bg-gray-50 even:dark:bg-gray-800 border-b dark:border-gray-700">
                    <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        <%= user.first_name %>
                    </td>
                    <td class="px-6 py-4">
                        <%= user.last_name %>
                    </td>
                    <td class="px-6 py-4">
                        <%= user.msidn %>
                    </td>
                    <td class="px-6 py-4">
                        <%= user.email %>
                    </td>
                    <td class="px-6 py-4">
                        <%= get_role_name(user.role_id )%>
                    </td>
                    <td class="px-6 py-4">
                        <%= user.inserted_at %>
                    </td>
                    <td class="px-6 py-4">
                        <button>Delete</button>
                    </td>
                </tr>
                <% end %>
            </tbody>
        </table>
    </div>
</div>
  </main>
</div>

    """
  end



end
