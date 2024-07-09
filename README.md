# Penpot Plugin Starter Elm Template

This repository is designed to be your starting point for creating plugins for Penpot. Follow these instructions to set up your development environment and start building your own Penpot plugins.

## Getting Started

### Clone the Repository

Begin by cloning this repository to your local machine. Use the following command in your terminal:

```bash
git clone --depth 1 https://github.com/aaaaargZombies/penpot-plugin-starter-elm-template
```

This command clones the latest version of the template into a folder named `penpot-plugin`.

### Configure the Plugin

Next, you need to edit the plugin's configuration file:

1. Navigate to the `penpot-plugin` directory.
2. Open the `manifest.json` file located in the `/public` folder.
3. Make any necessary changes to the configuration. Note that any modifications to this file require you to restart the development server for changes to take effect.

### Run the Development Server

To start the development server, run the following command in your terminal:

```bash
npm run dev
```

Once the server is running, open your web browser and go to `http://localhost:4400` to view your plugin in action. Now is ready to be loaded in Penpot.

## Development

### Technologies Used

This plugin template uses several key technologies:

- **TypeScript**
- **Vite**
- **[Elm](https://elm-lang.org/)**

Tests and formatting are run on a pre-commit hook via [Husky](https://typicode.github.io/husky/)

### Libraries Included

The template includes two Penpot libraries to assist in your development:

- `@penpot/plugin-styles`: This library provides utility functions and resources to help you style your components consistently with [Penpot's design system](https://penpot.github.io/penpot-plugins/).
- `@penpot/plugin-types`: This library includes types and API descriptions for interacting with the Penpot plugin API, facilitating the development of plugins that can communicate effectively with the Penpot app.

### `hello world`

The repo demonstrates modifying state in `Main.elm` and communicating between the UI and `plugin.ts` where there is access to the [penpot API](https://penpot-docs-plugins.pages.dev/technical-guide/plugins/api/), this is currently done by transparently passing messages through `main.ts` but some intermediate processing could also be done here as there is access to some browser APIs that are not available in either `plugin.ts` or `Main.elm`.

The communication is a bit overly complicated (why say there is a change and require a request to see what the change is?) but I wanted to flesh out the whole life-cycle to give something easy to modify.

## Build Your Plugin

When you're ready to build your plugin for production, run the following command:

```bash
npm run build
```

This command compiles your TypeScript and Elm code into JavaScript, creating a `dist` folder that contains all the files necessary to deploy your plugin.

## Useful resources

- [Penpot plugin documentation](https://penpot-docs-plugins.pages.dev/technical-guide/plugins/)
- [Sample plugins](https://github.com/penpot/penpot-plugins)
- [Elm guide](https://guide.elm-lang.org/)
- [Welcome to Elm! video series](https://www.youtube.com/playlist?list=PLuGpJqnV9DXq_ItwwUoJOGk_uCr72Yvzb)
