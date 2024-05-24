<header class="flex justify-between items-center px-6 py-3 bg-emDark">
  <div class="flex relative">
    <a href={~p"/"}>
      <img src="/images/logo.svg" alt="Logo" class="h-8 w-auto" />
    </a>
    <a href={~p"/"} class="mr-6">
      <div class="text-white font-brand font-bold text-3xl">BettIng</div>
    </a>
     <div>
      <input
        type="text"
        class="rounded-lg focus:outline-none focus:border-emLavender focus:ring-0 px-3 py-1 bg-emDark-dark placeholder-emDark-light text-white font-brand font-regular text-sm mr-5 border-white"
        placeholder="Search..."
      />
      <button class="mt-2 mr-2 text-white text-[1rem] font-brand font-bold hover:text-emDark-light">
        All Countries
      </button>
    </div>
  </div>
  <!-----profile----->
    <div class="relative">
    <button
      class="img-down-arrow"
      type="button"
      id="user-menu-button"
      phx-click={ElixirBetWeb.Layouts.App.toggle_dropdown_menu()}
    >
      <img src="/images/user-image.svg" alt="Profile Image" class="round-image-padding w-8 h-8" />
    </button>
    <div
      id="dropdown_menu"
      phx-click-away={ElixirBetWeb.Layouts.App.toggle_dropdown_menu()}
      class="dropdown-menu-arrow absolute right-0 mt-2 py-2 w-48 bg-emDark rounded-lg shadow-xl border border-white"
      hidden="true"
    >
      <%= if @current_user do %>
        <.link
          href={~p"/users/settings"}
          class="menu-item border-b border-white border-opacity-50"
          role="menuitem"
          tabindex="-1"
          method="get"
          id="user-menu-item-0"
        >
          Signed in as <%= @current_user.email %>
        </.link>

        <.link
          href={~p"/users/log_out"}
          class="menu-item"
          role="menuitem"
          tabindex="-1"
          method="delete"
          id="user-menu-item-3"
        >
          Sign out
        </.link>
      <% else %>
        <.link
          href={~p"/users/log_in"}
          class="menu-item border-b border-white border-opacity-50"
          role="menuitem"
          tabindex="-1"
          method="get"
          id="user-menu-item-0"
        >
          Sign in
        </.link>
        <.link
          href={~p"/users/register"}
          class="menu-item"
          role="menuitem"
          tabindex="-1"
          method="get"
          id="user-menu-item-1"
        >
          Register
        </.link>
      <% end %>
    </div>
  </div>
</header>
<main>
  <.flash_group flash={@flash} />
  <div class="flex h-screen bg-gray-200">
  <!-- Sidebar -->
 <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">
        <nav class="text-white text-base font-semibold pt-3">
            <a href={~p"/dashboard"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-tachometer-alt mr-3"></i>
                Dashboard
            </a>
             <a href={~p"/users"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-sticky-note mr-3"></i>
                Users
            </a>
            <a href={~p"/roles"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-sticky-note mr-3"></i>
                Roles
            </a>
            <a href={~p"/permissions"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-table mr-3"></i>
                Permissions
            </a>
            <a href={~p"/teams"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-table mr-3"></i>
                Teams
            </a>
            <a href={~p"/leagues"}class="flex items-center active-nav-link text-white py-4 pl-6 nav-item">
                <i class="fas fa-align-left mr-3"></i>
                Leagues
            </a>
            <a href={~p"/matches"}class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-tablet-alt mr-3"></i>
                Matches
            </a>
            <a href={~p"/history"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-tablet-alt mr-3"></i>
                Bet Histrory
            </a>
            <a href={~p"/wallets"} class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
                <i class="fas fa-tablet-alt mr-3"></i>
                Wallet
            </a>
        </nav>

    </aside>
  <!-- Main content -->
<div class="flex flex-col flex-grow ml-2 mb-4 mr-4">
<div class="flex justify-between mb-4 pt-4">
  <!-- Button on the left -->
  <a href={~p"/"} class="bg-orange-500 hover:bg-black-700 text-white font-bold py-2 px-4 rounded">
    Back
  </a>
</div>
 <%= @inner_content %>
<div class="relative overflow-x-auto shadow-md ">
</div>
  </div>
</div>

</main>
<h1 class="text-emLavender-dark px-4 space-x-2">table</h1>
<footer class="h-[120px] w-full flex justify-center text-white px-16 py-20 font-brand font-regular text-xs">
  <div class="w-full px-10">
    <div class="border-t-[1px] border-white w-full"></div>
    <div class="flex items-center space-x-2 py-6">
      <img src="/images/logo.svg" alt="Elixir Mentor Logo" class="h-8 w-8" />
      <p>
        © <span id="current-year" phx-hook="CurrentYear"></span>
        Betting  All rights reserved.
      </p>
      <div class="text-emLavender-dark px-4 space-x-2">
        <a href={~p"/"} class="hover:underline">Terms</a>
        <a href={~p"/"} class="hover:underline">Privacy</a>
        <a href={~p"/"} class="hover:underline">About</a>
      </div>
    </div>
  </div>
</footer>
