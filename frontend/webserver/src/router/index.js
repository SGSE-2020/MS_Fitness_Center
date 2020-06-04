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
import EditPersonalData from '@/components/edit_personal_data'
import AddMember from '@/components/add_member'
import RequestTrainingplan from '@/components/request_trainingplan'
import RequestTreatment from '@/components/request_treatment'
import Login from '@/components/login'

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
    },
    {
      path: '/profile/edit',
      name: 'EditPersonalData',
      component: EditPersonalData
    },
    {
      path: '/members/add',
      name: 'AddMember',
      component: AddMember
    },
    {
      path: '/trainingplan/request',
      name: 'RequestTrainingplan',
      component: RequestTrainingplan
    },
    {
      path: '/treatment/request',
      name: 'RequestTreatment',
      component: RequestTreatment
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    }
  ]
})
