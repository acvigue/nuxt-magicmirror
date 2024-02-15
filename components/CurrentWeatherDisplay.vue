<template>
  <div class="flex gap-4 items-center justify-end w-full">
    <img :src="`/weather_icons/${icon}.png`" alt="Weather icon" class="h-20" />
    <span class="text-7xl font-extralight">{{ temperature }}°</span>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

const props = defineProps<{
  api_key: string;
  location_id: number;
}>();

const iconTable: {
  [key: string]: string;
} = {
  "01d": "01",
  "02d": "03",
  "03d": "04",
  "04d": "06",
  "09d": "09",
  "10d": "08",
  "11d": "11",
  "13d": "14",
  "50d": "13",
  "01n": "01n",
  "02n": "03n",
  "03n": "04n",
  "04n": "06n",
  "09n": "09n",
  "10n": "08n",
  "11n": "11n",
  "13n": "14n",
  "50n": "13n",
};

const temperature = ref(0);
const icon = ref("");

const fetchWeather = async () => {
  try {
    const response = await fetch(
      `https://api.openweathermap.org/data/2.5/weather?units=imperial&id=${props.location_id}&appid=${props.api_key}`
    );
    const data = await response.json();

    temperature.value = data.main.temp.toFixed(0);
    icon.value = iconTable[data.weather[0].icon];
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  fetchWeather();
  const interval = setInterval(fetchWeather, 300000); // Fetch every 5 minutes
  onUnmounted(() => {
    clearInterval(interval);
  });
});
</script>
