const PasswordFieldHandler = {
  mounted() {
    console.log("render hooks");

    this.handleEvent("show_password_confirmation", (e) => {
      let password_field = document.getElementById("reg_password_confirmation");
      if (password_field.type === "password") {
        password_field.setAttribute("type", "text");
      } else {
        password_field.setAttribute("type", "password");
      }
    });
    this.handleEvent("show_password", (e) => {
      console.log("woy show password");
      let password_field = document.getElementById("reg_password");
      if (password_field.type === "password") {
        password_field.setAttribute("type", "text");
      } else {
        password_field.setAttribute("type", "password");
      }
    });
  },
};

export default PasswordFieldHandler;
