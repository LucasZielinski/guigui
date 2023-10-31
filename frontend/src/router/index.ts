import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView.vue'
import HomeView from '../views/HomeView.vue'
import WorkingTimeView from '../components/WorkingTime.vue'
import ClockView from '../views/ClockView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: { name: 'home' }
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView
    },
    {
      path: '/home',
      name: 'home',
      component: HomeView
    },
    {
      path: '/workingtime/:userId',
      name: 'workingtime',
      component: WorkingTimeView
    },
    {
      path: '/clock/:username',
      name: 'clock',
      component: ClockView
    },
  ]
})

export default router
