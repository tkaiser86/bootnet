# bootnetResult methods:
# print.bootnetResult <- function(x, ...){
#   print(x[['graph']])
# }

summary.bootnetResult <- function(object, ...){
  
  directed <- object$directed
  
  if (directed){
    ind <- matrix(TRUE,ncol(object$graph),ncol(object$graph))
  } else {
    ind <- upper.tri(object$graph,diag=FALSE)
  }
  
  
  cat("\nNumber of nodes:",nrow(object[['graph']]),
      "\nNumber of non-zero edges:",sum(object[['graph']][ind]!=0),"/",sum(ind),
      "\nDensity:",mean(object[['graph']][ind]) 
      # "\nNumber of estimated intercepts:",NROW(object[['intercepts']])
      )
}

plot.bootnetResult <- function(x,weighted, signed, directed, labels,
                               layout = "spring",
                               parallelEdge = TRUE, cut = 0,
                               theme = "colorblind", ...){

  if (missing(weighted)){
    weighted <- x$weighted
  }
  if (missing(signed)){
    signed <- x$signed
  }
  if (missing(directed)){
    directed <- x$directed
  }
  
  wMat <- x[['graph']]
  if (!isTRUE(weighted)){
    wMat <- sign(wMat)
  }
  if (!isTRUE(signed)){
    wMat <- abs(wMat)
  }
  
  if (missing(labels)){
    labels <- x[['labels']]
  }
  
  qgraph::qgraph(wMat,labels=labels,directed=directed,
                 parallelEdge = parallelEdge,
                 theme = theme,
                 cut = cut, layout = layout,  ...)
}
