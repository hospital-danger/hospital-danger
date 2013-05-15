<!DOCTYPE html>
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Hospitals May Be Hazardous to Your Health</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="css/screen.css">
  <script src="js/modernizr.js"></script>
</head>

<body>
  <header>
    <img src="img/header.png">
  </header>
  <div class="container">
    <video id="the-video">
      <source src="video/mp4/video.mp4" />
      <source src="video/webm/video.webm" />
    </video>
    <div class="video-controls">
      <div class="button-play paused" title="Play/Pause video">Play/pause</div>
      <div class="progress">
        <div class="buffer-bar"></div>
        <div class="time-bar"></div>
        <div class="time-elapsed">00:00</div>
        <div class="time-left">00:00</div>
      </div>
    </div>
    <h1 class="chapter-title"></h1>
    <nav class="chapter-list">
      <ul>
        <!-- append chapters here -->
      </ul>
    </nav>

    <!-- A SAFE PLACE -->
    <div class="element" id="million">million</div>
    <div class="element" id="people">
      <!-- person icon, which will be duplicated -->
    </div>
    <div class="element" id="causes-of-death">
      <div class="citation">http://www.cdc.gov/nchs/fastats/lcod.htm</div> <!-- TODO: how to represent our citations and external resources -->
      <ul> <!-- Taken from http://www.cdc.gov/nchs/data/dvs/deaths_2010_release.pdf, starting on page 14 -->
        <li>Heart Disease</li>
        <li>Cancer</li>
        <li id="hospital-injury-insertion-point"></li> <!-- Here we will insert 'Hospital injury' -->
        <li>Chronic lower respiratory disease</li>
        <li>Stroke</li>
        <li>Accidents</li>
        <li>Alzheimer&rsquo;s disease</li>
        <li>Diabetes</li>
        <li>Influenza and Pneumonia</li>
        <li>Intentional self-harm</li>
        <li>Septicemia</li>
        <li>Chronic liver disease and cirrhosis</li>
        <li>Essential hypertension and hypertensive renal disease</li>
        <li>Parkinson&rsquo;s disease</li>
        <li>Pneumonitis</li>
        <li>Salmonella infections</li>
        <li>Shigellosis and amebiasis</li>
        <li>Certain other intestinal infections</li>
        <li>Tuberculosis</li>
        <li>Respiratory tuberculosis</li>
        <li>Other tuberculosis</li>
        <li>Whooping cough</li>
        <li>Scarlet fever and erysipelas</li>
        <li>Meningococcal infection</li>
        <li>Septicemia</li>
        <li>Syphilis</li>
        <li>Acute poliomyelitis</li>
        <li>Arthropod-borne viral encephalitis</li>
        <li>Measles</li>
        <li>Viral hepatitis</li>
        <li>Human immunodeficiency virus </li>
        <li>Malaria</li>
        <li>Other and unspecified infectious and parasitic disease</li>
        <li>Malignant neoplasm</li>
      </ul>
    </div>
    <!-- QUALITY OF CARE -->
    <div class="element" id="report-cards">
      <!-- report icon; three are drawn, then we replicate 147 times -->
    </div>
    <div class="element" id="us-map">
      <!-- US map created from the report card squares -->
    </div>
    <!-- DECEPTIVELY SIMPLE -->
    <canvas class="element" id="bacteria"></canvas> <!-- bacteria; three are drawn, then we replicate and animate -->
    <!-- DENY AND DEFEND -->
    <div class="element" id="slashed-circle">
      <!-- represents "deny and defend"; we can show those words on either side or animate other things into the slashed circle -->
    </div>
    <div class="element" id="open-circle">
      <!-- represents the hospitals that are trying to take responsibility; we'll show a logo or a map here... -->
    </div>
    <!-- MALPRACTICE IN PRACTICE -->
    <a class="element" href="#can-you-sue" id="lawsuits">
      <!-- lawsuit icon; one rectangle is drawn, then we replicate 49 times and cross out 49 of the 50 -->
    </a>
    <aside id="can-you-sue">
      <a href="#" class="close-aside">&times;</a>
      <h2>Can you sue?</h2>
      <p>Probably not.</p>
      <blockquote>
        Quote from the study.
      </blockquote>
      <div class="decision-tree">
        <div class="decision" id="decision-1">
          <p>What happened to you?</p>
          <a href="#outcome-negative">Infection</a>
          <a href="#decision-3">Medication error</a>
          <a href="#decision-3">Surgical error</a>
        </div>
        <div class="decision" id="decision-3">
          <p>What is your identity?</p>
          <a href="#outcome-negative">Low Income</a>
          <a href="#outcome-negative">Elderly</a>
          <a href="#outcome-negative">Non-white</a>
          <a href="#decision-4">Upper-class white male</a>
        </div>
        <div class="decision" id="decision-4">
          <p>How severe was the injury?</p>
          <a href="#outcome-negative">Emotional distress</a>
          <a href="#outcome-negative">Minor injury</a>
          <a href="#outcome-positive">Permanent injury</a>
          <a href="#outcome-negative">Death</a>
        </div>
        <div class="decision" id="decision-5">
          <p>What state are you from?</p>
          <a href="#outcome-negative">TODO: lenient states]</a>
          <a href="#outcome-positive">Any other state</a>
        </div>
        <div class="outcome" id="outcome-negative">
          <p>No case.</p>
          <a href="#decision-1">Try again</a>
          <a id="end-decision-tree">Continue</a>
        </div>
        <div class="outcome" id="outcome-positive">
          <p>Congratulations! You might have a case.</p>
          <a href="#decision-1">Try again</a>
          <a id="end-decision-tree">Continue</a>
        </div>
      </div>
    </aside>
    <!-- IS IT GETTING BETTER? -->
    <div class="element" id="dollar-sign">
      <!-- represents "penny pinching"; the dollar sign is shrunken or squeezed -->
    </div>
    <div class="element" id="dirty-hand">
      <!-- represents "hand washing" or the lack thereof; we trace a line around the hand and then bring our bacteria back to crawl all over it -->
      <div class="hand"></div> <!-- outline of hand -->
      <div class="hand-bacterium"></div> <!-- one of many -->
    </div>
  </div>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="js/popcorn.js"></script>
  <script src="js/jquery.scrollTo.js"></script>
  <script src="js/script.js"></script>
</body>

</html>