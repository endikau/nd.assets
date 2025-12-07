function setupWordCloud(words, elementId = 'wordclo') {
  
  function render() {
    renderWordCloud(words, elementId);
  }

  // Run once on page load
  window.addEventListener('load', render);

  // Observe the element's resize
  const target = document.getElementById(elementId);
  if (!target) return;

  const observer = new ResizeObserver(entries => {
    for (let entry of entries) {
      if (entry.target.id === elementId) {
        render();
      }
    }
  });

  observer.observe(target);
}

function renderWordCloud(words, containerId) {

  const container = document.getElementById(containerId);
  if (!container) return;

  container.innerHTML = "";

  const width = container.offsetWidth;
  const height = container.offsetHeight;

  const svg = d3.select("#" + containerId).append("svg")
    .attr("viewBox", `0 0 ${width} ${height}`)
    .append("g")
    .attr("transform", `translate(${width / 2},${height / 2})`);

  d3.layout.cloud()
    .size([width, height])
    .words(words)
    .padding(2)
    .rotate(d => d.rotate)
    .fontSize(d => d.size)
    .font("Open Sans")
    .spiral("rectangular")
    .on("end", draw)
    .start();

  function draw(words) {
    svg.selectAll("text")
      .data(words)
      .enter().append("text")
      .style("font-family", "Open Sans")
      .style("fill", d => d.color)
      .style("font-size", d => d.size + "px")
      .attr("text-anchor", "middle")
      // .attr("transform", d => `translate(${d.x},${d.y}) rotate(${d.rotate})`)
      .attr("transform", d => "translate(" + d.x + "," + d.y + ") rotate(" + d.rotate + ")")
      .text(d => d.text);
  }
}


// function renderWordCloud(words, containerId) {
//   const container = document.getElementById(containerId);
//   if (!container) return;

//   container.innerHTML = "";

//   const width = container.offsetWidth;
//   const height = container.offsetHeight;

//   d3.layout.cloud()
//     .size([width, height])
//     .words(words.map(d => ({ ...d })))
//     .padding(1)
//     .font("Source Serif 4")
//     .fontSize(d => d.size)
//     .rotate(() => 0) // stick to horizontal for rectangular layout
//     .spiral("rectangular") // <-- switch here
//     .on("end", draw)
//     .start();

//   function draw(words) {
//     svg.selectAll("text")
//       .data(words)
//       .enter().append("text")
//       .style("font-family", "Source Serif 4")
//       .style("fill", () => d3.schemeCategory10[Math.floor(Math.random() * 10)])
//       .style("font-size", d => d.size + "px")
//       .attr("text-anchor", "middle")
//       .attr("transform", d => `translate(${d.x},${d.y}) rotate(${d.rotate})`)
//       .text(d => d.text);
//   }
// }
