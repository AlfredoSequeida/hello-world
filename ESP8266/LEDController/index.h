const char * indexHTML = R""""(
<!DOCTYPE html>
<html>
  <head>
    <meta content="text/html;charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta content="utf-8" http-equiv="encoding" />
    <title>Hello World!</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@simonwep/pickr/dist/themes/nano.min.css"
    />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,900;1,900&display=swap"
      rel="stylesheet"
    />
    <style>
      body,
      html {
        font-family: "Roboto", sans-serif;
        background-color: #18191a;
      }
      .presets {
        display: flex;
        justify-content: space-evenly;
        flex-wrap: wrap;
      }
      .preset {
        flex: 1 0 21%; /* explanation below */
        height: 100px;
        margin: 10px;
        border-radius: 20px;
      }
      .modal {
        display: none;
        position: absolute;
        justify-content: space-evenly;
        padding: 20px;
        height: 90%;
        width: 80%;
        border-radius: 20px;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        color: #fff;
        background-color: #1d1d1d;
        box-shadow: rgb(0, 0, 0) 0 1px 10px;
        z-index: 1;
      }
      .modal-container {
        width: 100%;
        margin-top: 80px;
      }
      .close-modal {
        position: absolute;
        right: 0;
        cursor: pointer;
      }
      .btn {
        position: absolute;
        bottom: 0;
        right: 0;
        background-color: #d3d3d3;
        border: none;
        border-radius: 10px;
        color: white;
        padding: 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 10px;
        cursor: pointer;
        font-family: "Roboto", sans-serif;
      }
      .slidecontainer {
        width: 100%;
      }

      .slider {
        -webkit-appearance: none;
        width: 100%;
        height: 15px;
        border-radius: 5px;
        background: #d3d3d3;
        outline: none;
        opacity: 0.7;
        -webkit-transition: 0.2s;
        transition: opacity 0.2s;
      }

      .slider::-webkit-slider-thumb {
        -webkit-appearance: none;
        appearance: none;
        width: 25px;
        height: 25px;
        border-radius: 50%;
        background: #d3d3d3;
        cursor: pointer;
      }

      .slider::-moz-range-thumb {
        width: 25px;
        height: 25px;
        border-radius: 50%;
        background: #d3d3d3;
        cursor: pointer;
      }
      .checkbox-container {
        display: block;
        position: relative;
        padding-left: 35px;
        margin-bottom: 12px;
        margin-top: 20px;
        cursor: pointer;
        font-size: 22px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      /* Hide the browser's default checkbox */
      .checkbox-container input {
        position: absolute;
        opacity: 0;
        cursor: pointer;
        height: 0;
        width: 0;
      }

      /* Create a custom checkbox */
      .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 25px;
        width: 25px;
        background-color: #eee;
      }

      /* On mouse-over, add a grey background color */
      .checkbox-container:hover input ~ .checkmark {
        background-color: #ccc;
      }

      /* When the checkbox is checked, add a blue background */
      .checkbox-container input:checked ~ .checkmark {
        background-color: #2196f3;
      }

      /* Create the checkmark/indicator (hidden when not checked) */
      .checkmark:after {
        content: "";
        position: absolute;
        display: none;
      }

      /* Show the checkmark when checked */
      .checkbox-container input:checked ~ .checkmark:after {
        display: block;
      }

      /* Style the checkmark/indicator */
      .checkbox-container .checkmark:after {
        left: 9px;
        top: 5px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 3px 3px 0;
        -webkit-transform: rotate(45deg);
        -ms-transform: rotate(45deg);
        transform: rotate(45deg);
      }

      .blue-purple-gradient {
        background: linear-gradient(
          90deg,
          rgb(193, 19, 177) 0%,
          rgb(0, 212, 255) 100%
        );
      }
      .red-blue-gradient {
        background: linear-gradient(
          90deg,
          rgb(255, 0, 0) 0%,
          rgb(0, 0, 255) 100%
        );
      }
      .crimson-gradient {
        background: linear-gradient(
          90deg,
          rgb(100, 43, 115) 0%,
          rgb(198, 66, 110) 100%
        );
      }
      .combi-gradient {
        background: linear-gradient(
          90deg,
          rgb(255, 224, 0) 0%,
          rgb(121, 159, 12) 50%,
          rgb(0, 65, 106) 100%
        );
      }
      @keyframes gradient {
        0% {
          background-position: 0% 50%;
        }
        50% {
          background-position: 100% 50%;
        }
        100% {
          background-position: 0% 50%;
        }
      }
    </style>
  </head>
  <body>
    <div id="modal" class="modal">
      <div class="close-modal" onclick="closeModal()">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="50"
          height="50"
          fill="currentColor"
          class="bi bi-x"
          viewBox="0 0 16 16"
        >
          <path
            d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"
          />
        </svg>
      </div>
      <div class="modal-container">
        <h3>Brightness: <span id="brightness-value">100</span>%</h3>
        <div class="slidecontainer">
          <input
            type="range"
            min="1"
            max="100"
            value="100"
            class="slider"
            id="brightness-range"
          />
        </div>

        <label class="checkbox-container"
          >Animate
          <input type="checkbox" onclick="toggleAnimation()" />
          <span class="checkmark"></span>
        </label>

        <button
          id="set-color-btn"
          type="button"
          class="btn"
          onclick="processGradient()"
        >
          Set Color!
        </button>
      </div>
    </div>
    <div class="color-picker"></div>
    <div class="presets">
      <div class="preset blue-purple-gradient" onclick="openModal(event)"></div>
      <div class="preset red-blue-gradient" onclick="openModal(event)"></div>
      <div class="preset crimson-gradient" onclick="openModal(event)"></div>
      <div class="preset combi-gradient" onclick="openModal(event)"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@simonwep/pickr/dist/pickr.min.js"></script>

    <script>
      // brightness slider
      const brightnessRange = document.getElementById("brightness-range");
      const brightnessValue = document.getElementById("brightness-value");
      const setColorButton = document.getElementById("set-color-btn");
      const modalEl = document.getElementById("modal");

      let gradientStyleString = "";

      // default gradient config
      // gradient: array of arrays with gradient info
      // brightness max: 255, min: 0
      // animated: decides if the gradient should move
      let gradientConfig = {
        gradient: [
          [0, 255, 0, 0],
          [255, 0, 0, 255],
        ],
        brightness: 255,
        animated: false,
      };

      brightnessRange.oninput = function () {
        brightnessValue.innerHTML = this.value;
        setColorButton.style.filter = `brightness(${this.value}%)`;
        gradientConfig.brightness = Math.round(this.value * 2.55);
      };

      function toggleAnimation() {
        if (gradientConfig.animated) {
          setColorButton.style.backgroundSize = "100%";
          setColorButton.style.animation = "";
        } else {
          setColorButton.style.backgroundSize = "200% 200%";
          setColorButton.style.animation = "gradient 2s ease infinite";
        }

        gradientConfig.animated = !gradientConfig.animated;
      }

      // Simple example, see optional options for more configuration.
      const pickr = Pickr.create({
        el: ".color-picker",
        theme: "nano",

        swatches: [
          "rgba(244, 67, 54, 1)",
          "rgba(233, 30, 99, 1)",
          "rgba(156, 39, 176, 1)",
          "rgba(103, 58, 183, 1)",
          "rgba(63, 81, 181, 1)",
          "rgba(33, 150, 243, 1)",
          "rgba(3, 169, 244, 1)",
          "rgba(0, 188, 212, 1)",
          "rgba(0, 150, 136, 1)",
          "rgba(76, 175, 80, 1)",
          "rgba(139, 195, 74, 1)",
          "rgba(205, 220, 57, 1)",
          "rgba(255, 235, 59, 1)",
          "rgba(255, 193, 7, 1)",
        ],

        components: {
          // Main components
          preview: true,
          hue: true,

          // Input / output Options
          interaction: {
            hex: true,
            rgba: true,
            hsla: true,
            hsva: true,
            cmyk: true,
            input: true,
            clear: true,
          },
        },
      });

      pickr.on("change", (source, instance) => {
        const [r, g, b, a] = source.toRGBA();
        setSolidColor(r, g, b);
      });

      function processGradient() {
        const gradientValues = gradientStyleString.split(",");

        /*example gradient
        [
          [0,225,0,0],
          [225,0,0,225]
        ]
        */

        let gradient = [];

        for (let i = 0; i < gradientValues.length; i++) {
          //get values for gradient
          let index, r, g, b;

          if (gradientValues[i].includes("rgb")) {
            // this is start of the values we need for each index
            r = parseInt(cleanUpString(gradientValues[i]).replace("rgb(", ""));
            g = parseInt(cleanUpString(gradientValues[i + 1]));

            // split percent and blue value
            const split = cleanUpString(gradientValues[i + 2]).split(")");

            b = parseInt(split[0]);
            index = Math.round(parseInt(split[1].replace("%", "")) * 2.55);

            gradient.push([index, r, g, b]);
          }
        }
        console.log(gradientConfig);
        gradientConfig.gradient = gradient;
        setGradientColor();
        closeModal();
      }

      function cleanUpString(s) {
        s = s.replace(/\s/g, "");
        return s;
      }

      function setSolidColor(r, g, b) {
        fetch("set-solid-color", {
          method: "POST",
          headers: {
            "Content-Type": "application/json;",
          },
          body: JSON.stringify({
            r: r,
            g: g,
            b: b,
          }),
        });
      }

      function setGradientColor() {
        fetch("set-gradient-color", {
          method: "POST",
          headers: {
            "Content-Type": "application/json;",
          },
          body: JSON.stringify(gradientConfig),
        });
      }

      function openModal(e) {
        const style = getComputedStyle(e.target);

        // storing gradient style string
        gradientStyleString = style.backgroundImage;

        // set button gradient
        setColorButton.style.backgroundImage = style.backgroundImage;
        modalEl.style.display = "flex";
      }

      function closeModal() {
        const modalEl = document.getElementById("modal");
        modalEl.style.display = "none";
      }
    </script>
  </body>
</html>
)"""";