// #import "@preview/uhb-community-templates:0.1.0" as uhb-presentation

#import "./../presentation.typ" as uhb-presentation
#import uhb-presentation: *

#set text(lang: "de")

#polylux.enable-handout-mode(false)


#show: slides.with(
  title: [Titel],
  series: [Titel der Präsentation ODER des Vortragenden],
  klinik: [Faculty 03],
  orga: [Organisationseinheit],

  author: [Univ. Prof. Dr. Maximilian Mustermann],
  email: none,  // link("mailto:your-name@uni-bremen.de"),

  // logo: none,

  paper: "presentation-16-9",  // 4-3
  toc: false,
  show-date: true,
  
  page-numbering: (current, total) => { [ #strong[#current] / #total ] },
  
  // if you want to be fancy
  //  display the page number as a fraction in %
  /*page-numbering: (current, total) => {[
    #calc.round(
      eval(
        str(current) + "/" +
        str(total) + "* 100"
      ),
      digits: 3
    )%
  ]},*/
)





// Use #slide to create a slide and style it using your favourite Typst functions
#slide[
  #set align(horizon)
  = Very minimalist slides

  #lorem(10)
]


#slide[
  == list

  - abc
  - def
    - ghi
    - jkl
      - mno
      - pqr
        - stu
        - vwx

]


#slide[
  == This slide changes!

  You can always see this.
  // Make use of features like #uncover, #only, and others to create dynamic content
  #polylux.uncover(2)[But this appears later!]
  
]


#slide[
  == side by side text

  #polylux.toolbox.side-by-side[
    #lorem(7)
  ][
    #lorem(10)
  ][
    #lorem(5)
  ]

  #polylux.toolbox.side-by-side(gutter: 3mm, columns: (1fr, 2fr, 1fr))[
    #rect(width: 100%, stroke: none, fill: aqua)
  ][
    #rect(width: 100%, stroke: none, fill: teal)
  ][
    #rect(width: 100%, stroke: none, fill: eastern)
  ]

]
