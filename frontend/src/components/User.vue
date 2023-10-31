<template>
  <div class="flex-grow text-black m-5 p-5">
    <div v-if="users.length > 0" class="flex justify-between items-center mb-2">
      <h2 class="text-lg font-semibold">List of Users</h2>
      <button @click="openCreateUserModal" class="bg-blue-500 hover-bg-blue-700 text-white font-semibold 
        py-2 px-4 rounded-md focus-outline-none focus-ring-2 focus-ring-pastel-blue">
        Create User
      </button>
    </div>
    <div v-if="users.length > 0">
      <ul>
        <li v-for="user in users" :key="user.id" class="flex-grow flex items-center">
          <div class="flex-grow">
            {{ user.username }} - {{ user.email }}
          </div>
          <div class="action-btn-container m-3">
            <div class="action-btn" @click="openEditModalForUser(user)">
              <font-awesome-icon :icon="['fa', 'edit']"/>
            </div>
            <div class="action-btn" @click="openDeleteModalForUser(user)">
              <font-awesome-icon :icon="['fa', 'trash']" class="text-red-500"/>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <div v-if="users.length == 0">
      <h2 class="text-lg font-semibold">List of Users</h2>
      <div class="my-4">
        No user found
      </div>
      <button @click="openCreateUserModal" class="bg-blue-500 hover-bg-blue-700 text-white font-semibold 
        py-2 px-4 rounded-md focus-outline-none focus-ring-2 focus-ring-pastel-blue mt-2">
        Create User
      </button>
    </div>
  </div>

  <!-- Edit Modal -->
  <EditModal
    v-if="selectedUserToEdit"
    :title="'Edit User: ' + selectedUserToEdit.username"
    @close="closeEditModal"
    @validate="editUser"
  >
    <div>
      <div class="mb-4 flex flex-col items-center">
        <input v-model="selectedUserToEdit.username" type="text" placeholder="Username" class="mb-2 p-2 rounded border border-gray-300 mt-5">
        <input v-model="selectedUserToEdit.email" type="text" placeholder="Email" class="p-2 rounded border border-gray-300">
      </div>
      <input v-model="selectedUserToEdit.id" type="hidden">
    </div>
  </EditModal>
  
   <!-- Delete Modal -->
  <DeleteModal
    v-if="selectedUserToDelete"
    :title= selectedUserToDelete.username
    @close="closeDeleteModal"
    @delete="deleteUser"
  >
  </DeleteModal>

  <!-- Create User Modal -->
  <CreateModal
    v-if="createUserModalOpen"
    :title="'Create User'"
    @close="closeCreateUserModal"
    @create="createUserModal"
  >
  <div>
    <div class="mb-4 flex flex-col items-center mt-4">
      <input v-model="newUser.username" type="text" placeholder="Username" class="mb-2 p-2 rounded border border-gray-300 mt-2">
      <input v-model="newUser.email" type="text" placeholder="Email" class="p-2 rounded border border-gray-300">
    </div>
  </div>
  </CreateModal>
</template>

<script setup lang="ts">
import * as Vue from 'vue'
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { useRoute, useRouter } from 'vue-router'
import EditModal from './modal/UserEditModal.vue';
import DeleteModal from './modal/UserDeleteModal.vue';
import CreateModal from './modal/UserCreateModal.vue';

const username = ref('')
const email = ref('')
const router = useRouter()
const route = useRoute()
const user = ref(null)
const apiLink = 'http://localhost:4000/api';
const users = ref([]);
const newUser = ref({
  username: '',
  email: '',
});

// API Functions

async function login() {
  try {
      const response = await axios.get(apiLink + `/users?email=${email.value}&username=${username.value}`)
      if (response.status === 200 && response.data.data.length > 0) {

        const userData = response.data.data[0]; 
        const userDataSubset = {
        id: userData.id,
        username: userData.username,
        email: userData.email};

        // Store the subset in local storage
        localStorage.setItem('userData', JSON.stringify(userDataSubset));
      } else {
          alert('Identifiants incorrects.')
      }
    } catch (error) {
        console.error(error)
    }
}

async function getAllUsers() {
  try {
    const response = await axios.get(apiLink + '/users');
    if (response.status === 200) {
      users.value = response.data.data;
    } else {
      alert('Failed to fetch users.');
    }
  } catch (error) {
    console.error(error);
  }
}

async function deleteUserById(userId: any) {
  try {
    const response = await axios.delete(apiLink + `/users/${userId}`);
    if (response.status === 204) {
      window.location.reload()
    } else {
      alert('Failed to delete user.');
    }
  } catch (error) {
    console.log(error);
  }
}

async function editUserById(userId: any, userData: any) {
  let userDataJson = {
      user: userData,
    };
  try { 
    const response = await axios.put(apiLink + `/users/${userId}`, userDataJson);
    if (response.status === 200) {
      let userDataStorage = localStorage.getItem('userData');
      if (userDataStorage) {
        const data = JSON.parse(userDataStorage);
        let currentUserId = data.id;
        if(userId == currentUserId ){
          localStorage.clear()
          localStorage.setItem('userData', JSON.stringify(userData));
          window.location.reload()
        }
      }
    } else {
      alert('Failed to update user.');
    }
  } catch (error) {
    console.log(error);
  }
}

function createUserModal() {
  if(newUser.value != null){
    createUser(newUser.value)
  }
  closeCreateUserModal()
}

async function createUser(userData: any) {
  let userDataJson = {
      user: userData,
    };
  try {
    const response = await axios.post(apiLink + `/users`, userDataJson);
    if (response.status === 201) {

    } else {
      alert('Failed to create user.');
    }
  } catch (error) {
    console.log(error);
  }
}

// Modal functions

const selectedUserToEdit = ref(null);
const selectedUserToDelete = ref(null);
const createUserModalOpen = ref(false);

function openEditModalForUser(user: null) {
    selectedUserToEdit.value = user;
}

function openDeleteModalForUser(user: null) {
  selectedUserToDelete.value = user;
}

function editUser() {
  if(selectedUserToEdit.value != null && selectedUserToEdit.value.id != null){
    editUserById(selectedUserToEdit.value.id, selectedUserToEdit.value)
  }
  closeEditModal()
}

function deleteUser() {
  if(selectedUserToDelete.value != null && selectedUserToDelete.value.id != null){
    deleteUserById(selectedUserToDelete.value.id)
  }
  closeDeleteModal()
}

function closeEditModal() {
    selectedUserToEdit.value = null;
}

function closeDeleteModal() {
  selectedUserToDelete.value = null;
}

const openCreateUserModal = () => {
  createUserModalOpen.value = true;
};

const closeCreateUserModal = () => {
  createUserModalOpen.value = false;
};

// On load
onMounted(() => {
  getAllUsers();
});

</script>

<style scoped>

  .action-btn-container {
    @apply inline-flex;
    @apply rounded-lg;
    @apply border;
    @apply border-gray-500;
    padding: 2px;
    @apply bg-white;
    align-items: center; 
  }

  .action-btn {
    @apply h-8;
    @apply w-8;
    @apply rounded-sm;
    @apply flex;
    @apply items-center;
    @apply justify-center;
    @apply cursor-pointer;
  }

  .action-btn:hover {
    @apply bg-gray-200;
  }
</style>