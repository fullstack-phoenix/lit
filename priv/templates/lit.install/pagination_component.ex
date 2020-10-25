defmodule <%= inspect context.web_module %>.Live.Admin.Common.PaginationComponent do
  use <%= inspect context.web_module %>, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def path(socket, page) do
    Routes.admin_product_index_path(socket, :index, page: page)
  end

  def current_page?(page_number, idx) do
    page_number == idx
  end

  def first_page?(page_number) do
    page_number <= 1
  end
  def last_page?(page_number, total_pages) do
    page_number >= total_pages
  end

  def render(assigns) do
    if assigns[:total_pages] > 1 do
      ~L"""
      <nav id="pagination" class="flex pt-4">
        <%%= if first_page?(@page_number) do %>
          <%%= live_redirect "Prev", to: path(@socket, @page_number), class: "mr-1 bg-gray-100 px-3 py-2 text-sm font-medium text-blue-700 focus:outline-none inline-flex items-center opacity-50 cursor-not-allowed" %>
        <%% else %>
          <%%= live_redirect "Prev", to: path(@socket, @page_number - 1), class: "mr-1 px-2 py-2 text-sm font-medium text-blue-700 active:text-blue-700 hover:text-blue-400 focus:outline-none focus:shadow-outline-white transition duration-150 ease-in-out inline-flex items-center" %>
        <%% end %>

        <%%= for idx <-  Enum.to_list(1..@total_pages) do %>
          <%%= if current_page?(@page_number, idx) do %>
            <%%= live_redirect idx, to: path(@socket, idx), class: "mr-1 px-3 py-2 text-sm border border-transparent rounded bg-yellow-600 text-white focus:outline-none inline-flex items-center opacity-50 cursor-not-allowed" %>
          <%% else %>
            <%%= live_redirect idx, to: path(@socket, idx), class: "mr-1 px-2 py-2 text-sm font-medium text-blue-700 active:text-blue-700 hover:text-blue-400 focus:outline-none focus:shadow-outline-white transition duration-150 ease-in-out inline-flex items-center" %>
          <%% end %>
        <%% end %>

        <%%= if last_page?(@page_number, @total_pages) do %>
          <%%= live_redirect "Next", to: path(@socket, @page_number), class: "bg-gray-100 px-3 py-2 text-sm font-medium text-blue-700 focus:outline-none inline-flex items-center opacity-50 cursor-not-allowed" %>
        <%% else %>
          <%%= live_redirect "Next", to: path(@socket, @page_number + 1), class: "px-2 py-2 text-sm font-medium text-blue-700 active:text-blue-700 hover:text-blue-400 focus:outline-none focus:shadow-outline-white transition duration-150 ease-in-out inline-flex items-center" %>
        <%% end %>
      </nav>
      """
    else
      ~L"""
      <nav id="pagination"></nav>
      """
    end
  end
end
