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

  const layout = d3.layout.cloud()
    .size([width, height])
    .words(words.map(d => Object.assign({}, d)))
    .padding(5)
    .font("Open Sans")
    .fontSize(d => d.size)
    .rotate(d => d.rotate)
    .on("end", draw);

  layout.start();

  function draw(words) {
    d3.select("#" + containerId).append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
      .selectAll("text")
      .data(words)
      .enter().append("text")
      .style("font-size", d => d.size + "px")
      .style("font-family", "Open Sans")
      .style("fill", d => d.color)
      .attr("text-anchor", "middle")
      .attr("transform", d => "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")")
      .text(d => d.term);
  }
}
