// Spliced into every page by `[spine] prelude`, so the import has to be
// root-absolute: a relative path would resolve against each page's directory.
#import "/content/_lib/template.typ": template
#import "/content/_lib/components.typ": entity, notice, page-columns, side-box
#import "@rookery/core:0.1.0": footnote, idea, outline, window

#show: template
