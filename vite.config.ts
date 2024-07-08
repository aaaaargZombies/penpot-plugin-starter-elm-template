import { defineConfig } from "vite";
import { plugin as elmPlugin } from "vite-plugin-elm";

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        plugin: "src/plugin.ts",
        index: "./index.html",
      },
      output: {
        entryFileNames: "[name].js",
      },
    },
  },
  plugins: [elmPlugin()],
  preview: {
    port: 4400,
  },
});
