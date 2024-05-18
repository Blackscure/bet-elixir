defmodule ElixirBetWeb.CreatePermissionLive do
use ElixirBetWeb, :live_view

alias ElixirBet.Repo
alias ElixirBet.Roles.Role
alias ElixirBet.Permissions.Permission


def render(assigns) do
~L"""

<div class="leading-loose">
  <form phx-submit="submit_permission" class="p-10 bg-gray-900 rounded shadow-xl">
    <p class="text-lg text-white font-medium pb-4">Create Permission</p>
    <div class="inline-block mt-2 w-full pr-1">
      <label for="role_id" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Role Name</label>
      <select name="role_id" id="role_id" class="block w-full p-2 mb-6 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
        <option selected disabled>Select a role</option>
        <%= for role <- @roles do %>
          <option value="<%= role.id %>"><%= role.name %></option>
        <% end %>
      </select>
    </div>

    <div class="mb-5">
      <label for="action" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Action Name</label>
      <input type="text" id="action" name="action" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Action Name" required />
    </div>

    <div class="mb-5">
      <label for="resource" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Resource Name</label>
      <input type="text" id="resource" name="resource" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Resource" required />
    </div>

    <div class="mt-6">
      <button class="px-4 py-1 text-white font-light tracking-wider bg-orange-700 rounded" type="submit">Save</button>
    </div>
  </form>
</div>

"""
end
# Mount function fetches roles from the database and assigns them to the socket.
def mount(_params, _session, socket) do
  roles = Role |> Repo.all()
  {:ok, assign(socket, roles: roles)}
end


def handle_event("submit_permission", %{"role_id" => role_id, "action" => action, "resource" => resource}, socket) do
  # Check if the permission already exists in the database.
  existing_permission = Repo.get_by(Permission, role_id: String.to_integer(role_id), action: action, resource: resource)

  case existing_permission do
    nil ->
      # Permission does not exist, proceed with insertion.
      permission = %Permission{
        role_id: String.to_integer(role_id),
        action: action,
        resource: resource
      }

      case Repo.insert(permission) do
        {:ok, _permission} ->
          # On success, set a success flash message and send a response to the client to redirect.
          {:noreply, socket |> put_flash(:info, "Permission created successfully") |> redirect(to: "/permissions")}
        {:error, _changeset} ->
          # On error, set an error flash message.
          {:noreply, socket |> put_flash(:error, "Failed to create permission")}
      end
    _ ->
      # Permission already exists, set a flash message to inform the user.
      {:noreply, socket |> put_flash(:error, "Permission already exists")}
  end
end




end
