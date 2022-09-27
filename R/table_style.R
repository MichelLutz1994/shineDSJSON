
table_frame <-
  function() {
    htmltools::withTags(table(class = 'display',
                              thead(
                                tr(
                                  th(rowspan = 2, 'Latitude'),
                                  th(rowspan = 2, 'Longitude'),
                                  th(rowspan = 2, 'Month'),
                                  th(rowspan = 2, 'Year'),
                                  th(class = 'dt-center', colspan = 3, 'Cloud'),
                                  th(rowspan = 2, 'Ozone'),
                                  th(rowspan = 2, 'Pressure'),
                                  th(rowspan = 2, 'Surface Temperature'),
                                  th(rowspan = 2, 'Temperature'),
                                  tr(lapply(rep(
                                    c('High', 'Low', 'Mid'), 1
                                  ), th))
                                )
                              )))
  }


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
    searching = TRUE,
    editable = FALSE,
    scroller = TRUE,
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
