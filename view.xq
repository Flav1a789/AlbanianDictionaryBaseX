module namespace page = 'http://basex.org/modules/web-page';

declare
  %rest:path("/dictionary/browse")
  %rest:GET
  %output:method("html")
  %output:doctype-system("about:legacy-compat")
function page:dictionary() {
  <html>
    <head>
      <title>Albanian Dictionary</title>
      <meta charset="UTF-8"/>
      <style>
        body {{ font-family: Arial, sans-serif; margin: 0; padding: 0; }}
        header {{ 
          background-color: #E41E25; /* Albanian flag red */
          color: white;
          padding: 20px;
          text-align: center;
          display: flex;
          justify-content: center;
          align-items: center;
          position: relative;
        }}
        .flag-icon {{
          position: absolute;
          right: 30px;
          width: 40px;
          height: 28px;
          background-color: #E41E25; /* Red background */
          display: flex;
          justify-content: center;
          align-items: center;
        }}
        .double-eagle {{
          width: 24px;
          height: 24px;
          color: #000000; /* Black eagle */
        }}
        .content {{
          margin: 20px;
        }}
        .entry {{ 
          border: 1px solid #ccc; 
          margin-bottom: 15px; 
          padding: 10px;
          border-radius: 5px;
          border-left: 4px solid #E41E25; /* Albanian flag red */
        }}
        .lemma {{ font-weight: bold; }}
        .pos {{ color: #333; font-style: italic; }}
        .def {{ margin-top: 5px; }}
        .search-box {{ 
          margin-bottom: 20px; 
          background-color: #f5f5f5;
          padding: 15px;
          border-radius: 5px;
        }}
        .search-box input {{ 
          padding: 8px; 
          width: 70%; 
          border: 1px solid #ccc;
          border-radius: 3px;
        }}
        .search-box button {{ 
          padding: 8px 15px; 
          background-color: #000000; /* Black - Albanian flag color */
          color: white;
          border: none;
          border-radius: 3px;
          cursor: pointer;
        }}
        .add-btn {{ 
          background: #E41E25; /* Albanian flag red */
          color: white; 
          padding: 8px 15px;
          text-decoration: none;
          border-radius: 3px;
          display: inline-block;
        }}
        .edit-btn {{ 
          background: #000000; /* Black - Albanian flag color */
          color: white; 
          border: none; 
          padding: 5px 10px;
          cursor: pointer;
          border-radius: 3px;
        }}
        .home-link {{
          margin-top: 20px;
          display: inline-block;
          color: #E41E25;
          text-decoration: none;
          font-weight: bold;
        }}
        .home-link:hover {{
          text-decoration: underline;
        }}
      </style>
    </head>
    <body>
      <header>
        <h1>Albanian Dictionary</h1>
        <div class="flag-icon">
          <!-- Simplified Albanian flag symbol -->
          <svg class="double-eagle" viewBox="0 0 300 300" xmlns="http://www.w3.org/2000/svg">
            <path d="M150,20 C120,40 100,60 90,100 C80,140 90,180 150,220 C210,180 220,140 210,100 C200,60 180,40 150,20 Z" fill="black"/>
            <path d="M150,70 C140,75 135,80 132,90 C129,100 132,110 150,120 C168,110 171,100 168,90 C165,80 160,75 150,70 Z" fill="#E41E25"/>
          </svg>
        </div>
      </header>
      
      <div class="content">
        <div class="search-box">
          <form action="/dictionary/browse" method="get">
            <input type="text" name="search" placeholder="Search for a word..."/>
            <button type="submit">Search</button>
          </form>
          <div style="margin-top: 10px;">
            <a href="/dictionary/add-entry" class="add-btn">Add New Entry</a>
          </div>
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
        
        <div>
          <a href="/dictionary" class="home-link">Back to Home</a>
        </div>
      </div>
    </body>
  </html>
};
