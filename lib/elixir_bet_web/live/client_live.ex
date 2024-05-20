defmodule ElixirBetWeb.ClientLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Accounts
  alias ElixirBet.Repo
  alias ElixirBet.Roles.Role

  def mount(_params, _session, socket) do
      {:ok, users} = Accounts.list_users()
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

<div class="relative overflow-x-auto shadow-md ">
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
                    Mobile Numebr
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
                    <button phx-click="soft_delete_user" phx-value-id="<%= user.id %>" phx-value-role-id="<%= user.role_id %>">Delete</button>
                </td>
    </tr>
  <% end %>
        </tbody>
    </table>
</div>
    """
  end



end
