
# functions

## NS

shiny中的命名空间，https://www.rdocumentation.org/packages/shiny/versions/1.5.0/topics/NS

```R
library(shiny)
ns <- NS("test")
ns
# function (id) 
# {
    # if (length(id) == 0) 
        # return(ns_prefix)
    # if (length(ns_prefix) == 0) 
        # return(id)
    # paste(ns_prefix, id, sep = ns.sep)
# }
# <bytecode: 0x00000220bfa4da60>
# <environment: 0x00000220bfa1c248>
ns("haha")
# [1] "test-haha"
```


