# Albanian Dictionary Project

This project is an online Albanian-English dictionary based on the **Albanian-English Dictionary by Leonard Newmark (2005)**, available at [http://www.seelrc.org:8080/albdict/](http://www.seelrc.org:8080/albdict/). The goal of this project is to create a web-based platform for browsing, searching, and editing Albanian dictionary entries, while also improving my skills in **BaseX** and contributing to open-source Albanian language resources.

## Features

- **Browse Dictionary**: View a list of Albanian words with their phonetic forms, parts of speech, and definitions.
- **Search Functionality**: Search for specific words in the dictionary.
- **Edit Entries**: Edit existing dictionary entries to improve accuracy and completeness.
- **User-Friendly Interface**: It aims to be an intuitive web interface for easy navigation.

## Technologies Used

- **BaseX**: A native XML database used to store and query the dictionary data.
- **XQuery**: Used for server-side logic and RESTXQ endpoints.
- **HTML/CSS**: For the front-end interface.
- **RESTXQ**: A framework for building RESTful web services in BaseX.

## Project Structure

The project consists of the following files:

1. **`index.xq`**: The homepage of the dictionary, providing an overview and links to browse the dictionary.
2. **`view.xq`**: Displays the dictionary entries and allows users to search for specific words.
3. **`edit-entry.xq`**: A form for editing dictionary entries.
4. **`save-entry.xq`**: Handles the submission of edited entries and updates the database.

## Setup Instructions

### Prerequisites

- **BaseX**: Install BaseX from [https://basex.org/download/](https://basex.org/download/).
- **Dictionary Data**: The dictionary data is stored in an XML database DICTIONARY based on the structure of Leonard Newmark's Albanian-English Dictionary.

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
