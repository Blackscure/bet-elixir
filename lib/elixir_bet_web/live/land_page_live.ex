defmodule ElixirBetWeb.LandPageLive do
  use ElixirBetWeb, :live_view





  def render(assigns) do
    ~L"""
<div class="flex justify-center items-start mt-0">
  <div class="bg-gray-200 p-4">
   <div class="ml-4 mr-64 pb-4">
        <span class="font-bold text-orange-600">League Name</span>
    </div>
    <div class="flex">
      <!-- Team information -->
      <div class="ml-4 mr-64">
        <div class="mb-1">
          <h6 class="text-sm font-semibold">Home Team</h6>
          <h6 class="text-sm font-semibold">Away Team</h6>
        </div>
        <div class="mb-2">
          <span class="text-xs">Time</span>
          <span class="text-xs">Date</span>
        </div>
      </div>
      <!-- Buttons -->
      <div class="flex">
        <button class="bg-black hover:bg-orange-700  border border-orange-700  text-white font-bold py-2 px-4 rounded mr-2">Home Odd</button>
        <button class="bg-black hover:bg-orange-700  border border-orange-700 text-white font-bold py-2 px-4 rounded mr-2">Draw Odd</button>
        <button class="bg-black hover:bg-orange-700  border border-orange-700 text-white font-bold py-2 px-4 rounded">Away Odd</button>
      </div>
    </div>
  </div>

    <div class=" bg-emDark p-4">
    <div class="flex bg-emLavender shadow-inner rounded-tl-lg rounded-br">
      <!-- Team information -->
        <div class="ml-4 flex items-center">
        <div class="w-8 h-8 flex items-center justify-center text-black rounded-full bg-orange-500 mr-4">
            <h6 class="text-sm font-semibold">0</h6>
        </div>
        <div class="mr-64">
            <h6 class="text-sm font-semibold pt-1">Bet Slip</h6>
        </div>
        <div class="mr-4">
            <h6 class="text-sm font-semibold pt-1">0.0</h6>
        </div>
        </div>


      </div>

    </div>
  </div>
</div>




    """
  end

end
