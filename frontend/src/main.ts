import './assets/main.css'
import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'
import '../index.css'
import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { faHouse, faChartLine, faTrash, faEdit, faRightFromBracket, faPlus, faPencil} from "@fortawesome/free-solid-svg-icons";
library.add(faHouse, faChartLine, faTrash, faEdit, faRightFromBracket, faPlus, faPencil);

const app = createApp(App).component("font-awesome-icon", FontAwesomeIcon);

app.use(createPinia())
app.use(router)

app.mount('#app')

