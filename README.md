# Tidy Tuesday Script Repo

## Description

Provide a concise and clear description of your project. Explain what it does and why it's useful or interesting.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## Installation

Describe the steps users need to follow to install and run your project. Include any dependencies that need to be installed and configuration steps.

```r
# Installation steps
install.packages("tidytuesdayR")
```

## Usage

Explain how to use your project. Provide examples and code snippets if necessary.

```r
#Sample Data Ingestion
date <- '2021-08-10'
#load in data
tuesdata <- tidytuesdayR::tt_load(date)
investment <- tuesdata$investment
```

## Features

List and briefly describe the key features of your project.

- Feature 1: Description
- Feature 2: Description
- ...

## Contributing

Explain how others can contribute to your project. Include guidelines for submitting bug reports, feature requests, and pull requests.

```markdown
1. Fork the project
2. Create a new branch (`git checkout -b feature/awesome-feature`)
3. Commit your changes (`git commit -am 'Add awesome feature'`)
4. Push to the branch (`git push origin feature/awesome-feature`)
5. Open a pull request
```

## License

Specify the license under which your project is distributed.

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

Mention and thank contributors, libraries, or resources that inspired or helped your project.

- Thanks to [Author 1](link-to-author1-profile)
- Inspired by [Project X](link-to-project-x)

## Contact

Provide your contact information so others can reach out to you with questions or feedback.

- Email: your.email@example.com
- Twitter: [@yourTwitterHandle](https://twitter.com/yourTwitterHandle)

---

Feel free to customize this template according to the specifics of your project. Providing clear and comprehensive information will help others understand, use, and contribute to your project more effectively.
