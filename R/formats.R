
#' create datatable layout options
#' @export
#' 
#' @return table_option object
#' 
table_options <- function() {
  list(
    dom = 'Bfrtip',
    #Bfrtip
    pageLength = 10,
    buttons = list(
      c('copy', 'csv', 'excel', 'pdf', 'print'),
      list(
        extend = "collection",
        text = 'Show All',
        action = DT::JS(
          "function ( e, dt, node, config ) {
          dt.page.len(-1);
          dt.ajax.reload();}"
        )
      ),
      list(
        extend = "collection",
        text = 'Show Less',
        action = DT::JS(
          "function ( e, dt, node, config ) {
          dt.page.len(10);
          dt.ajax.reload();}"
        )
      )
    ),
    deferRender = TRUE,
    lengthMenu = list(c(10, 20,-1), c('10', '20', 'All')),
    search = list(regex=TRUE, caseInsensitiv = FALSE),
    editable = FALSE,
    scroller = TRUE,
    responsive = TRUE,
    lengthChange = TRUE
    ,
    initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#517fb9', 'color': '#fff'});",
      "lengthMenu: [
        [10, 25, 50, -1],
        [10, 25, 50, 'All'],
      ]",
      "}"
    )
  )
}
