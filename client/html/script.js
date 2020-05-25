const app = new Vue({
  el: "#app",
  vuetify: new Vuetify(),
  data: {

    // Base App
    resourcename: "xf_characters",
    communityname: "XFCore",
    colors: {
      white: "#ffffff",
      lightblue: "#74b9ff",
      blue: "#0984e3",
      lightgray: "#b2bec3",
      midgray: "#636e72",
      darkgray: "#2d3436"
    },
    visible: false,

    // Character Menus Data
    characters: [],
    maxCharacters: 3,
    selectedGender: "male",

    // Menu Selection
    currentMenu: "manager",

    // Menu Manager Data
    showManagerDialog: false,
    nameRules: [
      v => !!v || "Name is required",
      v => (v && v.length >= 2) || "Name must be more than 2 characters",
      v => (v && v.length <= 15) || "Name must be less than 10 characters"
    ],
    ageRules: [
      v => !!v || "Age is required",
      v => (v && v > 17) || "You must have an 18 years or older character.",
      v => (v && v <= 80) || "You must have an 80 years or younger character."
    ],
    dialogData: {
      firstname: "",
      middlename: "",
      lastname: "",
      age: null,
      ismale: false
    },
  },
  methods: {
    SetResourceDefaults(data) {
      this.resource == data.resource;
      this.communityname = data.community;
      this.models = data.models;
    },

    // Menu Methods
    OpenUI() {
      console.log("OPENING UI");
      this.visible = true;
    },
    CloseUI() {
      this.visible = false;
    },
    ChangeUI(data) {
      this.currentMenu = data.menu
    },
    SendCharacters(data) {
      this.characters = data.characters
    },

    // Manager Menu Methods
    OpenDialog() {
      this.showManagerDialog = true;
    },
    CloseDialog() {
      this.showManagerDialog = false;
      this.$refs.newCharForm.reset();
    },
    CreateNewCharacter() {
      const valid = this.$refs.newCharForm.validate();
      if (valid) {
        axios.post(`http://${this.resourcename}/create_character`, JSON.stringify({
          character: this.dialogData
        }));
        this.CloseDialog();
      }
    },
    DeleteCharacter(id) {
      axios.post(`http://${this.resourcename}/delete_character`, JSON.stringify({
        id
      }))
    },
    SelectCharacter(id) {
      axios.post(`http://${this.resourcename}/select_character`, JSON.stringify({
        id
      }))
    },
  },
  mounted() {
    RegisterEvent("set_resource_defaults", this.SetResourceDefaults);
    RegisterEvent("open_ui", this.OpenUI);
    RegisterEvent("close_ui", this.CloseUI);
    RegisterEvent("change_ui", this.ChangeUI);
    RegisterEvent("send_characters", this.SendCharacters);
  },
})