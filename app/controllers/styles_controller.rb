class StylesController < ApplicationController
  def set
    if !params[:image_url]
      @url = "http://sphotos.xx.fbcdn.net/hphotos-snc6/184020_10150260094181987_694716986_7953469_6517626_n.jpg"
      @colors = ["#DEE7EE", "#BEBBAF", "#AC8F6A", "#8A7056", "#6E6352", "#4D4137", "#131415"]
    else
      @url = params[:image_url]
      begin
        extr = Prizm::Extractor.new(@url)
        @colors = extr.get_colors(7, false).sort { |a, b| b.to_hsla[2] <=> a.to_hsla[2] }.map { |p| extr.to_hex(p) }
        extr = nil
      rescue
        @colors = []
      end
    end
    
    #@url = params[:image_url] || "http://sphotos.xx.fbcdn.net/hphotos-snc6/184020_10150260094181987_694716986_7953469_6517626_n.jpg"
    #extr = Prizm::Extractor.new(@url)
    #@colors = extr.get_colors(7, false).sort { |a, b| b.to_hsla[2] <=> a.to_hsla[2] }.map { |p| extr.to_hex(p) }
    #extr = nil
    set_style
  end
  
  def customize
    @colors = params[:colors]
    set_style
  end
  
  private
  def set_style
    @less = %{
//
// Variables
// --------------------------------------------------


// Global values
// --------------------------------------------------

// Links
@linkColor:             #{@colors[4] || '#08c'};
@linkColorHover:        darken(@linkColor, 15%);

// Grays
@black:                 #{@colors[6] || '#000'};
@grayDark:              #{@colors[5] || '#222'}; 
@grayDarker:            darken(@grayDark, 10%);
@gray:                  #{@colors[3] || '#555'};
@grayLight:             #{@colors[2] || '#999'};
@grayLighter:           #{@colors[1] || '#eee'};
@white:                 #{@colors[0] || '#fff'};

// Accent colors
// -------------------------
@blue:                  #049cdb;
@blueDark:              #0064cd;
@green:                 #46a546;
@red:                   #9d261d;
@yellow:                #ffc40d;
@orange:                #f89406;
@pink:                  #c3325f;
@purple:                #7a43b6;


// Scaffolding
// -------------------------
@bodyBackground:        @white;
@textColor:             @grayDark;

// Typography
// -------------------------
@sansFontFamily:        "Helvetica Neue", Helvetica, Arial, sans-serif;
@serifFontFamily:       Georgia, "Times New Roman", Times, serif;
@monoFontFamily:        Monaco, Menlo, Consolas, "Courier New", monospace;

@baseFontSize:          14px;
@baseFontFamily:        @sansFontFamily;
@baseLineHeight:        20px;
@altFontFamily:         @serifFontFamily;

@headingsFontFamily:    inherit; // empty to use BS default, @baseFontFamily
@headingsFontWeight:    bold;    // instead of browser default, bold
@headingsColor:         inherit; // empty to use BS default, @textColor


// Tables
// -------------------------
@tableBackground:                   transparent; // overall background-color
@tableBackgroundAccent:             #f9f9f9; // for striping
@tableBackgroundHover:              #f5f5f5; // for hover
@tableBorder:                       @grayDark; // table and cell border


// Buttons
// -------------------------
@btnBackground:                     @white;
@btnBackgroundHighlight:            darken(@white, 10%);
@btnBorder:                         #bbb;

@btnPrimaryBackground:              @linkColor;
@btnPrimaryBackgroundHighlight:     spin(@btnPrimaryBackground, 20%);

@btnInfoBackground:                 #5bc0de;
@btnInfoBackgroundHighlight:        #2f96b4;

@btnSuccessBackground:              #62c462;
@btnSuccessBackgroundHighlight:     #51a351;

@btnWarningBackground:              lighten(@orange, 15%);
@btnWarningBackgroundHighlight:     @orange;

@btnDangerBackground:               #ee5f5b;
@btnDangerBackgroundHighlight:      #bd362f;

@btnInverseBackground:              #444;
@btnInverseBackgroundHighlight:     @grayDarker;


// Forms
// -------------------------
@inputBackground:               #fff;
@inputBorder:                   #ccc;
@inputBorderRadius:             3px;
@inputDisabledBackground:       @grayLighter;
@formActionsBackground:         #f5f5f5;

// Dropdowns
// -------------------------
@dropdownBackground:            @white;
@dropdownBorder:                rgba(0,0,0,.2);
@dropdownDividerTop:            #e5e5e5;
@dropdownDividerBottom:         @white;

@dropdownLinkColor:             @grayDark;

@dropdownLinkColorHover:        @white;
@dropdownLinkBackgroundHover:   @dropdownLinkBackgroundActive;

@dropdownLinkColorActive:       @dropdownLinkColor;
@dropdownLinkBackgroundActive:  @linkColor;



// COMPONENT VARIABLES
// --------------------------------------------------

// Z-index master list
// -------------------------
// Used for a bird's eye view of components dependent on the z-axis
// Try to avoid customizing these :)
@zindexDropdown:          1000;
@zindexPopover:           1010;
@zindexTooltip:           1030;
@zindexFixedNavbar:       1030;
@zindexModalBackdrop:     1040;
@zindexModal:             1050;


// Sprite icons path
// -------------------------
@iconSpritePath:          "../img/glyphicons-halflings.png";
@iconWhiteSpritePath:     "../img/glyphicons-halflings-white.png";


// Input placeholder text color
// -------------------------
@placeholderText:         @grayLight;


// Hr border color
// -------------------------
@hrBorder:                @grayLighter;


// Wells
// -------------------------
@wellBackground:                  #f5f5f5;


// Navbar
// -------------------------
@navbarCollapseWidth:             979px;

@navbarHeight:                    40px;
@navbarBackground:                darken(@navbarBackgroundHighlight, 5%);
@navbarBackgroundHighlight:       @grayDark;
@navbarBorder:                    darken(@navbarBackground, 12%);

@navbarText:                      @gray;
@navbarLinkColor:                 @gray;
@navbarLinkColorHover:            @grayLighter;
@navbarLinkColorActive:           @grayLighter;
@navbarLinkBackgroundHover:       transparent;
@navbarLinkBackgroundActive:      darken(@navbarBackground, 5%);

@navbarBrandColor:                @navbarLinkColor;

// Inverted navbar
@navbarInverseBackground:                #111111;
@navbarInverseBackgroundHighlight:       #222222;
@navbarInverseBorder:                    #252525;

@navbarInverseText:                      @grayLight;
@navbarInverseLinkColor:                 @grayLight;
@navbarInverseLinkColorHover:            @white;
@navbarInverseLinkColorActive:           @navbarInverseLinkColorHover;
@navbarInverseLinkBackgroundHover:       transparent;
@navbarInverseLinkBackgroundActive:      @navbarInverseBackground;

@navbarInverseSearchBackground:          lighten(@navbarInverseBackground, 25%);
@navbarInverseSearchBackgroundFocus:     @white;
@navbarInverseSearchBorder:              @navbarInverseBackground;
@navbarInverseSearchPlaceholderColor:    #ccc;

@navbarInverseBrandColor:                @navbarInverseLinkColor;


// Pagination
// -------------------------
@paginationBackground:                #fff;
@paginationBorder:                    #ddd;
@paginationActiveBackground:          #f5f5f5;


// Hero unit
// -------------------------
@heroUnitBackground:              @grayLighter;
@heroUnitHeadingColor:            inherit;
@heroUnitLeadColor:               inherit;


// Form states and alerts
// -------------------------
@warningText:             #c09853;
@warningBackground:       #fcf8e3;
@warningBorder:           darken(spin(@warningBackground, -10), 3%);

@errorText:               #b94a48;
@errorBackground:         #f2dede;
@errorBorder:             darken(spin(@errorBackground, -10), 3%);

@successText:             #468847;
@successBackground:       #dff0d8;
@successBorder:           darken(spin(@successBackground, -10), 5%);

@infoText:                #3a87ad;
@infoBackground:          #d9edf7;
@infoBorder:              darken(spin(@infoBackground, -10), 7%);


// Tooltips and popovers
// -------------------------
@tooltipColor:            #fff;
@tooltipBackground:       #000;
@tooltipArrowWidth:       5px;
@tooltipArrowColor:       @tooltipBackground;

@popoverBackground:       #fff;
@popoverArrowWidth:       10px;
@popoverArrowColor:       #fff;
@popoverTitleBackground:  darken(@popoverBackground, 3%);

// Special enhancement for popovers
@popoverArrowOuterWidth:  @popoverArrowWidth + 1;
@popoverArrowOuterColor:  rgba(0,0,0,.25);



// GRID
// --------------------------------------------------


// Default 940px grid
// -------------------------
@gridColumns:             12;
@gridColumnWidth:         60px;
@gridGutterWidth:         20px;
@gridRowWidth:            (@gridColumns * @gridColumnWidth) + (@gridGutterWidth * (@gridColumns - 1));

// 1200px min
@gridColumnWidth1200:     70px;
@gridGutterWidth1200:     30px;
@gridRowWidth1200:        (@gridColumns * @gridColumnWidth1200) + (@gridGutterWidth1200 * (@gridColumns - 1));

// 768px-979px
@gridColumnWidth768:      42px;
@gridGutterWidth768:      20px;
@gridRowWidth768:         (@gridColumns * @gridColumnWidth768) + (@gridGutterWidth768 * (@gridColumns - 1));


// Fluid grid
// -------------------------
@fluidGridColumnWidth:    percentage(@gridColumnWidth/@gridRowWidth);
@fluidGridGutterWidth:    percentage(@gridGutterWidth/@gridRowWidth);

// 1200px min
@fluidGridColumnWidth1200:     percentage(@gridColumnWidth1200/@gridRowWidth1200);
@fluidGridGutterWidth1200:     percentage(@gridGutterWidth1200/@gridRowWidth1200);

// 768px-979px
@fluidGridColumnWidth768:      percentage(@gridColumnWidth768/@gridRowWidth768);
@fluidGridGutterWidth768:      percentage(@gridGutterWidth768/@gridRowWidth768);
      
#{Lavish::Application::BOOTSTRAP}
    }
  end
end