module namespace page = 'http://basex.org/modules/web-page';

declare
  %rest:path("/dictionary/browse")
  %rest:GET
  %output:method("html")
  %output:doctype-system("about:legacy-compat")
function page:dictionary() {
  <html>
    <head>
      <title>Albanian Dictionary PROJECT TAL2</title>
      <meta charset="UTF-8"/>
      <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .entry {{ 
          border: 1px solid #ccc; 
          margin-bottom: 15px; 
          padding: 10px;
          border-radius: 5px;
        }}
        .lemma {{ font-weight: bold; }}
        .pos {{ color: #666; font-style: italic; }}
        .def {{ margin-top: 5px; }}
        .search-box {{ margin-bottom: 20px; }}
        .edit-btn {{ 
          background: #4CAF50; 
          color: white; 
          border: none; 
          padding: 5px 10px;
          cursor: pointer;
          border-radius: 3px;
        }}
      </style>
    </head>
    <body>
      <h1>Albanian Dictionary</h1>
      
      <div class="search-box">
        <form action="/dictionary/browse" method="get">
          <input type="text" name="search" placeholder="Search for a word..."/>
          <button type="submit">Search</button>
        </form>
      </div>
      
      {
        let $search := request:parameter("search")
        let $entries := 
          if ($search) then
            db:get("DICTIONARY")/bdd/entry[contains(lemma[@n="orth"], $search)]
          else
            db:get("DICTIONARY")/bdd/entry[position() <= 20]
        
        return
          for $entry in $entries
          return
            <div class="entry">
              <div class="lemma">
                {$entry/lemma[@n="orth"]/text()}
                <span class="phon"> [{$entry/lemma[@n="phon"]/text()}]</span>
              </div>
              <div class="pos">
                {string-join($entry/form/pos/text(), ", ")}
              </div>
              <div class="def">
                {$entry/def/text()}
              </div>
              <div style="margin-top: 10px;">
                <button class="edit-btn" onclick="window.location.href='/dictionary/edit-entry?id={$entry/lemma[@n="orth"]/text()}'">
                  Edit Entry
                </button>
              </div>
            </div>
      }
      
      <div style="margin-top: 20px;">
        <a href="/dictionary">Back to Home</a>
      </div>
    </body>
  </html>
};
