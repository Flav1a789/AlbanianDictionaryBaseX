module namespace page = 'http://basex.org/modules/web-page';

declare
  %rest:path("/dictionary")
  %rest:GET
  %output:method("html")
  %output:doctype-system("about:legacy-compat")
function page:index() {
  <html>
    <head>
      <title>Albanian Dictionary Project</title>
      <meta charset="UTF-8"/>
      <style>
        body {{ 
          font-family: Arial, sans-serif; 
          margin: 0; 
          padding: 0;
          background-color: #f5f5f5;
          display: flex;
          flex-direction: column;
          align-items: center;
          min-height: 100vh;
        }}
        .container {{
          max-width: 800px;
          width: 100%;
          padding: 20px;
        }}
        header {{
          background-color: #4CAF50;
          color: white;
          width: 100%;
          padding: 20px 0;
          text-align: center;
        }}
        .btn {{
          display: inline-block;
          background: #4CAF50;
          color: white;
          padding: 10px 20px;
          margin: 10px 0;
          text-decoration: none;
          border-radius: 4px;
          font-weight: bold;
        }}
        .about {{
          background: white;
          padding: 20px;
          border-radius: 5px;
          margin-top: 20px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }}
      </style>
    </head>
    <body>
      <header>
        <h1>Albanian Dictionary Project</h1>
      </header>
      
      <div class="container">
        <div style="text-align: center; margin: 30px 0;">
          <a href="/dictionary/browse" class="btn">Browse Dictionary</a>
        </div>
        
        <div class="about">
          <h2>About This Project</h2>
          <p>This online Albanian dictionary provides access to a comprehensive collection of Albanian terms with their definitions, phonetic representations, and grammatical information.</p>
          <p>Users can browse the dictionary, search for specific terms, and contribute by editing existing entries to improve accuracy and completeness.</p>
        </div>
      </div>
    </body>
  </html>
};
