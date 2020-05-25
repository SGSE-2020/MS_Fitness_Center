import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Home from '@/components/home'
import Devices from '@/components/devices'
import Courses from '@/components/courses'
import Abo from '@/components/abo'
import Profile from '@/components/profile'
import Members from '@/components/members'
import TrainingplanRequest from '@/components/trainingplan_requests'
import TreatmentRequest from '@/components/treatment_requests'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/home',
      name: 'Home',
      component: Home
    },
    {
      path: '/devices',
      name: 'Devices',
      component: Devices
    },
    {
      path: '/courses',
      name: 'Courses',
      component: Courses
    },
    {
      path: '/abo',
      name: 'Abo',
      component: Abo
    },
    {
      path: '/profile',
      name: 'Profile',
      component: Profile
    },
    {
      path: '/members',
      name: 'Members',
      component: Members
    },
    {
      path: '/requests/trainingplan',
      name: 'TrainingplanRequest',
      component: TrainingplanRequest
    },
    {
      path: '/requests/treatment',
      name: 'TreatmentRequest',
      component: TreatmentRequest
    }
  ]
})
