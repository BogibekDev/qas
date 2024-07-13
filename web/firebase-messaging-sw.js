importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
      apiKey: 'AIzaSyCw60hJD9COxycx7KcoQNedFR0kKZT7YKY',
      appId: '1:368224353430:web:0a26d2d743894f40e016b7',
      messagingSenderId: '368224353430',
      projectId: 'qoshkopravtosavdo',
      authDomain: 'qoshkopravtosavdo.firebaseapp.com',
      storageBucket: 'qoshkopravtosavdo.appspot.com',
      measurementId: 'G-ZH79Q1VHEK',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});