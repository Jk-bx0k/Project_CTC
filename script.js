const request = {
    id: "REQ001",
    studentId: "66390123",
    name: "สมชาย ใจดี",
    status: "รอตรวจสอบ"
};

localStorage.setItem("requestData", JSON.stringify(request));
const data = JSON.parse(localStorage.getItem("requestData"));

if (data) {
    document.getElementById("status").innerHTML =
        `สถานะคำร้อง: ${data.status}`;
}
