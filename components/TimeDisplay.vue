<script setup lang="ts">
const hourString = ref("");
const minuteString = ref("");
const secondString = ref("");

let counters: NodeJS.Timeout | null = null;

const updateTime = () => {
  const date = new Date();
  const hours = date.getHours() > 12 ? date.getHours() - 12 : date.getHours();
  hourString.value = hours.toString();
  minuteString.value = date.getMinutes().toString().padStart(2, "0");
  secondString.value = date.getSeconds().toString().padStart(2, "0");
};

onMounted(() => {
  updateTime();
  counters = setInterval(updateTime, 1000);
});

onBeforeUnmount(() => {
  clearInterval(counters!);
});
</script>

<template>
  <div class="flex justify-center items-end font-light text-7xl">
    <span>{{ hourString }}</span>
    <span>:</span>
    <span>{{ minuteString }}</span>
    <span class="text-5xl text-gray-300">:{{ secondString }}</span>
  </div>
</template>
