const app = new Vue({
  el: "#app",
  data: {
    // Base App
    resource: "xf_characters",
    communityname: "XFCore",

    // Colors
    colors: {
      white: "#ffffff",
      lightblue: "#74b9ff",
      blue: "#0984e3",
      lightgray: "#b2bec3",
      midgray: "#636e72",
      darkgray: "#2d3436"
    },

    // Menu Data
    visible: false,
    showManager: true,

    // Character Manager Data
    showDropdown: false,
    characters: [],
    maxCharacters: 4,
    
    // Character Creator Data
    pageIndex: 2,
    pages: [
      { name: "Data", page: "data" },
      { name: "Parents", page: "parents" },
      { name: "Components", page: "clothing" },
      { name: "Props", page: "props" },
      { name: "Overlays", page: "overlays" },
      { name: "Features", page: "features" },
      { name: "Finish", page: "finish" }
    ],

    firstname: "",
    middlename: "",
    lastname: "",
    age: 0,
    isMale: true,
    parents: { father: 0, mother: 0, mix: 0.5 },
    components: {
      [2]: { name: "Hair", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, primaryColor: 0, secondaryColor: 0, camPos: "face" },
      [3]: { name: "Arms", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" },
      [4]: { name: "Pants", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" },
      [6]: { name: "Shoes", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" },
      [7]: { name: "Accessories", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" },
      [8]: { name: "Undershirts", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" },
      [11]: { name: "Jackets", drawable: 0, texture: 0, maxDrawables: 10, maxTextures: 0, camPos: "normal" }
    },
    props: {
      [0]: { name: "Hats", drawable: 0, texture: 0, maxDrawables: 0, maxTextures: 0, camPos: "face" },
      [1]: { name: "Glasses", drawable: 0, texture: 0, maxDrawables: 0, maxTextures: 0, camPos: "face" },
      [2]: { name: "Ears", drawable: 0, texture: 0, maxDrawables: 0, maxTextures: 0, camPos: "face" },
      [6]: { name: "Watches", drawable: 0, texture: 0, maxDrawables: 0, maxTextures: 0, camPos: "left_arm" },
      [7]: { name: "Bracelets", drawable: 0, texture: 0, maxDrawables: 0, maxTextures: 0, camPos: "right_arm" }
    },
    overlays: {
      [0]: { name: "Blemishes", overlay: 0, min: 0, max: 23, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [1]: { name: "Facial Hair", overlay: 0, min: 0, max: 28, opacity: 0.0, colorType: 1, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [2]: { name: "Eyebrows", overlay: 0, min: 0, max: 33, opacity: 0.0, colorType: 1, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [3]: { name: "Ageing", overlay: 0, min: 0, max: 14, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [4]: { name: "Makeup", overlay: 0, min: 0, max: 74, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      //[5]: { name: "Blush", overlay: 0, min: 0, max: 6, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [6]: { name: "Complexion", overlay: 0, min: 0, max: 11, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [7]: { name: "Sun Damage", overlay: 0, min: 0, max: 10, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      //[8]: { name: "Lipstick", overlay: 0, min: 0, max: 9, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [9]: { name: "Moles & Freckles", overlay: 0, min: 0, max: 17, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [10]: { name: "Chest Hair", overlay: 0, min: 0, max: 16, opacity: 0.0, colorType: 1, color: 0, color_two: 0, disabled: true, camPos: "face" },
      [11]: { name: "Body Blemishes", overlay: 0, min: 0, max: 11, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "chest" },
      [12]: { name: "Add Body Blemishes", overlay: 0, min: 0, max: 1, opacity: 0.0, colorType: 0, color: 0, color_two: 0, disabled: true, camPos: "face" }
    },
    facefeatures: {
      [0]: { name: "Nose Width", scale: 0.0 },
      [1]: { name: "Nose Peak Height", scale: 0.0 },
      [2]: { name: "Nose Peak Length", scale: 0.0 },
      [3]: { name: "Nose Bone Height", scale: 0.0 },
      [4]: { name: "Nose Peak Lowering", scale: 0.0 },
      [5]: { name: "Nose Bone Twist", scale: 0.0 },
      [6]: { name: "Eyebrow Height", scale: 0.0 },
      [7]: { name: "Eyebrow Forward", scale: 0.0 },
      [8]: { name: "Cheek Bone Height", scale: 0.0 },
      [9]: { name: "Cheek Bone Width", scale: 0.0 },
      [10]: { name: "Cheek Width", scale: 0.0 },
      [11]: { name: "Eye Openings", scale: 0.0 },
      [12]: { name: "Lip Thickness", scale: 0.0 },
      [13]: { name: "Jaw Bone Width", scale: 0.0 },
      [14]: { name: "Back Jaw Bone Length", scale: 0.0 },
      [15]: { name: "Chin Bone Lowering", scale: 0.0 },
      [16]: { name: "Chin Bone Length", scale: 0.0 },
      [17]: { name: "Chin Bone Width", scale: 0.0 },
      [18]: { name: "Chin Hole Size", scale: 0.0 },
      [19]: { name: "Neck Thickness", scale: 0.0 }
    }

  },
  methods: {
    SetResourceDefaults(data) {
      this.resource == data.resource;
      this.communityname = data.community;
      this.models = data.models;
    },

    // Menu Methods
    ToggleUI(data) {
      this.visible = data.visible;
    },
    ToggleMenus(data) {
      this.showManager = data.showManager || !this.showManager;
    },

    // Creator Methods
    StartCreator() {
      axios.post(`http://${this.resource}/start_creator`, {});
    },
    SetCharacterData(data) {
      for (let [key, value] of Object.entries(data.components)) {
        if (this.components[key]) {
          this.components[key].maxDrawables = value
        }
      }

      for (let [key, value] of Object.entries(data.props)) {
        if (this.props[key]) {
          this.props[key].maxDrawables = value
        }
      }
    },

    // Creator Changed Events
    GenderChanged(data) {
      axios.post(`http://${this.resource}/gender_changed`, {
        ismale: this.isMale
      })
    },
    ParentsChanged() {
      axios.post(`http://${this.resource}/parents_changed`, this.parents)
    },
    ComponentDrawableChanged(id) {
      axios.post(`http://${this.resource}/component_drawable_changed`, {
        id,
        drawable: this.components[id].drawable
      }).then((results) => {
        this.components[id].maxTextures = results.data.textures;
        this.components[id].texture = 0;
      });
      axios.post(`http://${this.resource}/set_camera_focus`, {
        type: this.components[id].camPos
      })
    },
    ComponentTextureChanged(id) {
      axios.post(`http://${this.resource}/component_texture_changed`, {
        id,
        drawable: this.components[id].drawable,
        texture: this.components[id].texture
      });
      axios.post(`http://${this.resource}/set_camera_focus`, {
        type: this.components[id].camPos
      })
    },
    PropDrawableChanged(id) {
      axios.post(`http://${this.resource}/prop_drawable_changed`, {
        id,
        drawable: this.props[id].drawable
      }).then((results) => {
        this.props[id].maxTextures = results.data.textures
        this.props[id].texture = 0
      })
    },
    PropTextureChanged(id) {
      axios.post(`http://${this.resource}/prop_texture_changed`, {
        id,
        drawable: this.props[id].drawable,
        texture: this.props[id].texture
      });
    },
    HairColorChanged() {
      axios.post(`http://${this.resource}/set_hair_color`, {
        color: this.components[2].primaryColor,
        color_two: this.components[2].secondaryColor
      })
    },
    OverlayChanged(id) {
      axios.post(`http://${this.resource}/overlay_changed`, {
        id,
        overlay: this.overlays[id].overlay,
        opacity: this.overlays[id].opacity,
        colorType: this.overlays[id].colorType,
        color: this.overlays[id].color,
        color_two: this.overlays[id].color_two
      })
    },
    
  },
  mounted() {
    RegisterEvent("set_resource_defaults", this.SetResourceDefaults);
    RegisterEvent("toggle_ui", this.ToggleUI);
    RegisterEvent("toggle_menus", this.ToggleMenus);
    RegisterEvent("set_character_data", this.SetCharacterData);
  }
})