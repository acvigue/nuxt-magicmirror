<script setup lang="ts">
const dateString = ref("");

let counters: NodeJS.Timeout | null = null;

const updateDate = () => {
  const date = new Date();
  dateString.value = date.toLocaleDateString("en-US", {
    weekday: "long",
    year: undefined,
    month: "long",
    day: "numeric",
  });
};

onMounted(() => {
  updateDate();
  counters = setInterval(updateDate, 1000);
});

onBeforeUnmount(() => {
  clearInterval(counters!);
});
</script>

<template>
  <div
    class="flex justify-center items-end font-extralight text-gray-300 text-5xl"
  >
    <span>{{ dateString }}</span>
  </div>
</template>
