/**
 * This is a beamer template for the University of Bremne
 */


#import "@preview/polylux:0.4.0" as polylux

// colors for Uni Bremen CD
#import "colors.typ" as uhb_colors


#let logo_no_padd(..args) = image("./../img/UHB_Logo_Web_RGB.png", ..args)

#let uhb_logo_print(..args) = context {
  let L = 0.04 * measure(logo_no_padd(..args)).width

  set align(center + horizon)

  box(
    // fill: green,
    inset: (x: 5 * L, y: 5 * L),  // diese komische 5l regel
    stroke: 1pt + black,
    logo_no_padd(..args),
  )
}


#let custom-footer(
  logo: uhb_logo_print,
  footer-title: [Titel der Präsentation ODER des Vortragenden],
  orga: [Organisationseinheit],
  show-date: false,
  page-numbering: (n, total) => { [ #strong[#n] / #total ] },
) = {
  context {
    set text(fill: if page.fill != uhb_colors.blau0 { white } else { uhb_colors.blau0 })

    let current-margin = if page.margin == auto {
      (2.5 / 21) * calc.min(page.height, page.width)       
    } else {
      // TODO: scheint bisschen komplexer zu sein...
      0mm  // page.margin.left  .left .right .x .y oder so ...
    }

    place(bottom, dx: -current-margin)[
      #box(
        height: 100% + 1mm,
        width: 100% + 2 * current-margin
      )[
  
        #set align(center + horizon) 

        
        // #stack(dir: ltr, spacing: 1fr,
        #polylux.toolbox.side-by-side(gutter: 0mm, columns: (2fr, 1fr),
          [
            #{
              rect(width: 100%, height: 100%, stroke: none, fill: uhb_colors.rot0)[
                #set align(left)
                #stack(dir: ttb, spacing: 3mm,
                  text(size: 10pt, footer-title),
                  text(size: 12pt, weight: "semibold", orga)
                )
              ]
            }
          ],
          [
            #rect(width: 100%, height: 100%, stroke: none, fill: uhb_colors.rot2)[
              #set text(fill: black)
              #if here().page() > 1 {
                set text(size: 15pt)
                set align(right)
                box(inset: (x: 4mm))[
                  #stack(
                    dir: ttb, spacing: 3mm,
                    if show-date == true {
                      text(size: 10pt)[#datetime.today().display("[day]. [month repr:short] [year]")]
                    },
                    [
                      #page-numbering(counter(page).at(here()).first(), counter(page).final().first())
                    ]
                  ) 
                ]                          
              }
            ]
          ],
        )    
      ]
    ]
  }
}



#let slide(..args) = {
  polylux.slide(..args)
}


// --- template ---------------------------------------------------------------

#let slides(
  title: [Titel mit blauem Hintergrund],
  series: [Titel der Präsentation ODER des Vortragenden],
  klinik: [Universitätsklinik für XY],
  orga: [Organisationseinheit],

  author: [Univ. Prof. Dr. Maximilian Mustermann],
  email: none,  // link("mailto:n12345678@students.meduniwien.ac.at"),
  
  paper: "presentation-16-9",
  toc: false,
  show-date: true,
  logo: none,

  // page-numbering: (n, total) => { [ #strong[#n] / #total ] },
  
  // if you want to be fancy
  //  display the page number as a fraction in %
  page-numbering: (n, total) => {[
      #calc.round(
        eval(
          str(counter(page).at(here()).first()) + "/" +
          str(counter(page).final().first()) + "* 100"
        ),
        digits: 3
      )%
  ]},

  body

) = {
  set page(
    paper: paper,
    header: [
      #set text(size: 15pt)
      #show math.equation: set text(size: 15pt)

      #stack(dir: ltr, spacing: 1fr,
        uhb_logo_print(height: 1cm),
        box([some logo]),
        box([Example presentation title \ This is the subtitle]),
        box([Jane Doe, John Doe \ Bremen, 01.06.2021]),
        box([Faculty 03 \ Mathematics / Computerscience])
      )
    ],
    footer: custom-footer(
      footer-title: series,
      orga: orga,
      show-date: show-date,
      page-numbering: page-numbering
    )
  )

  set text(size: 25pt)
  show math.equation: set text(size: 25pt)
  
  // title slide
  slide[
    
    // #set text(size: 17pt)
    // #show math.equation: set text(size: 17pt)
    #set page(footer: none, header: none) // turn off footer

    #place(top + left, dx: -2cm, dy: -2cm, scope: "parent", float: true,
      uhb_logo_print(height: 1.5cm)
    )

    #set align(horizon)
    #v(-4cm)
    
    = #title
    
    #author \
    #klinik \
    #if email != none { text(size: 10pt, email) }
  ]

  // show toc if param is set
  if toc == true{
    slide()[
      #outline()
    ]
  }
  
  body
}
