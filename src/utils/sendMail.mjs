function sendEmail(mailOptions, transporter) {
  return new Promise((resolve, reject) => {
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error("Error sending verification email:", error);
        reject(error);
      } else {
        console.log("Verification email sent:", info.messageId);
        resolve(info);
      }
    });
  });
}

export default sendEmail;
