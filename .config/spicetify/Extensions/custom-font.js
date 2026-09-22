(function customFontExtension() {
  if (!Spicetify.Platform) {
    setTimeout(customFontExtension, 100);
    return;
  }

  const targetFont = '"LXGW Wenkai", sans-serif';

  const style = document.createElement("style");
  style.id = "spicetify-custom-font";
  style.innerHTML = `* { font-family: ${targetFont} !important; }`;
  document.head.appendChild(style);
})();
